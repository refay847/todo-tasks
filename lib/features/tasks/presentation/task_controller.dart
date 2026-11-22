import 'package:flutter/foundation.dart';
import '../../../core/storage/task_storage.dart';
import '../data/task_model.dart';

/// Holds all tasks across all 6 categories in a single persisted list.
/// Position in the list represents priority within each category.
class TaskController extends ChangeNotifier {
  TaskController({TaskStorage? storage})
      : _storage = storage ?? const TaskStorage();

  final TaskStorage _storage;
  List<TaskModel> _tasks = [];
  bool _isLoading = true;
  int _idCounter = 0;

  bool get isLoading => _isLoading;

  List<TaskModel> get allTasks => List.unmodifiable(_tasks);

  List<TaskModel> tasksFor(TaskCategory category) =>
      List.unmodifiable(_tasks.where((t) => t.category == category));

  List<TaskModel> pendingTasksFor(TaskCategory category) => List.unmodifiable(
        _tasks.where((t) => t.category == category && !t.isCompleted),
      );

  List<TaskModel> completedTasksFor(TaskCategory category) => List.unmodifiable(
        _tasks.where((t) => t.category == category && t.isCompleted),
      );

  int countFor(TaskCategory category) =>
      _tasks.where((t) => t.category == category).length;

  int completedCountFor(TaskCategory category) =>
      _tasks.where((t) => t.category == category && t.isCompleted).length;

  String _generateId() {
    _idCounter += 1;
    return '${DateTime.now().microsecondsSinceEpoch}_$_idCounter';
  }

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _tasks = await _storage.loadTasks();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask({
    required String title,
    required double target,
    required double remaining,
    required TaskCategory category,
    double step = kAmountStep,
  }) async {
    final cleanTitle = title.trim();
    if (cleanTitle.isEmpty || target <= 0) return;

    // Draft is not a real home category; fall back to Work if ever passed.
    final safeCategory = category.isDraft ? TaskCategory.work : category;
    final safeStep = step.clamp(kMinStep, kMaxStep).toDouble();

    final task = TaskModel(
      id: _generateId(),
      title: cleanTitle,
      target: target,
      remaining: remaining.clamp(0.0, target).toDouble(),
      step: safeStep,
      category: safeCategory,
    );

    _tasks = [..._tasks, task];
    await _commit();
  }

  Future<void> updateTask(
    String id, {
    required String title,
    required double target,
    required double remaining,
    TaskCategory? category,
    double? step,
  }) async {
    final cleanTitle = title.trim();
    if (cleanTitle.isEmpty || target <= 0) return;

    final index = _tasks.indexWhere((t) => t.id == id);
    if (index < 0) return;

    final old = _tasks[index];
    final nextCategory = category ?? old.category;
    final categoryChanged = nextCategory != old.category;
    final safeStep = step?.clamp(kMinStep, kMaxStep).toDouble();

    TaskCategory? nextPrevious = old.previousCategory;
    var clearPrevious = false;

    if (categoryChanged) {
      if (nextCategory.isDraft) {
        nextPrevious = old.category.isDraft ? old.previousCategory : old.category;
      } else {
        clearPrevious = true;
      }
    }

    final updated = old.copyWith(
      title: cleanTitle,
      target: target,
      remaining: remaining.clamp(0.0, target).toDouble(),
      step: safeStep,
      category: nextCategory,
      previousCategory: nextPrevious,
      clearPreviousCategory: clearPrevious,
    );

    final list = [..._tasks];
    if (categoryChanged) {
      list
        ..removeAt(index)
        ..add(updated);
    } else {
      // Same category: preserve exact position in place.
      list[index] = updated;
    }

    _tasks = list;
    await _commit();
  }

  /// Moves a task into Draft and remembers its current category for restore.
  Future<void> sendToDraft(String id) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index < 0) return;

    final current = _tasks[index];
    if (current.isDraft) return;

    final list = [..._tasks];
    final drafted = list.removeAt(index).copyWith(
          previousCategory: current.category,
          category: TaskCategory.draft,
        );
    _tasks = [...list, drafted];
    await _commit();
  }

  /// Restores a drafted task back to its previous category (fallback: Work).
  Future<TaskCategory?> restoreFromDraft(String id) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index < 0) return null;

    final current = _tasks[index];
    if (!current.isDraft) return null;

    final targetCategory = current.restoreCategory;
    final list = [..._tasks];
    final restored = list.removeAt(index).copyWith(
          category: targetCategory,
          clearPreviousCategory: true,
        );
    _tasks = [...list, restored];
    await _commit();
    return targetCategory;
  }

  /// Moves a task to any other category. Moving to Draft remembers its origin;
  /// moving out of Draft clears `previousCategory`.
  Future<void> moveTask(String id, TaskCategory targetCategory) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index < 0) return;

    final current = _tasks[index];
    if (current.category == targetCategory) return;

    if (targetCategory.isDraft) {
      await sendToDraft(id);
      return;
    }

    final list = [..._tasks];
    final moved = list.removeAt(index).copyWith(
          category: targetCategory,
          clearPreviousCategory: true,
        );
    _tasks = [...list, moved];
    await _commit();
  }

  /// Reorders unfinished tasks within a category (or all tasks inside Draft).
  Future<void> reorderCategory(
    TaskCategory category,
    int oldIndex,
    int newIndex,
  ) {
    final predicate = category.isDraft
        ? (TaskModel t) => t.category == TaskCategory.draft
        : (TaskModel t) => t.category == category && !t.isCompleted;
    return _reorderGroup(predicate, oldIndex, newIndex);
  }

  Future<void> _reorderGroup(
    bool Function(TaskModel) inGroup,
    int oldIndex,
    int newIndex,
  ) async {
    final group = _tasks.where(inGroup).toList();
    if (oldIndex < 0 || oldIndex >= group.length) return;
    if (newIndex > oldIndex) newIndex -= 1;
    newIndex = newIndex.clamp(0, group.length - 1).toInt();
    if (newIndex == oldIndex) return;

    group.insert(newIndex, group.removeAt(oldIndex));

    var cursor = 0;
    _tasks = _tasks.map((t) => inGroup(t) ? group[cursor++] : t).toList();
    await _commit();
  }

  Future<void> setRemaining(String id, double remaining) async {
    _tasks = _tasks.map((task) {
      if (task.id != id) return task;
      return task.copyWith(
        remaining: remaining.clamp(0.0, task.target).toDouble(),
      );
    }).toList();
    await _commit();
  }

  Future<void> toggleTask(String id) async {
    _tasks = _tasks.map((task) {
      if (task.id != id) return task;
      return task.copyWith(remaining: task.isCompleted ? task.target : 0.0);
    }).toList();
    await _commit();
  }

  /// Deletes a task and returns its snapshot + index so UNDO can restore it.
  Future<({TaskModel task, int index})?> deleteTask(String id) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index < 0) return null;

    final list = [..._tasks];
    final removed = list.removeAt(index);
    _tasks = list;
    await _commit();
    return (task: removed, index: index);
  }

  Future<void> insertTaskAt(TaskModel task, int index) async {
    if (_tasks.any((item) => item.id == task.id)) return;
    final list = [..._tasks];
    final safeIndex = index.clamp(0, list.length).toInt();
    list.insert(safeIndex, task);
    _tasks = list;
    await _commit();
  }

  Future<void> resetCategory(TaskCategory category) async {
    _tasks = _tasks.map((t) {
      if (t.category != category) return t;
      return t.copyWith(remaining: t.target);
    }).toList();
    await _commit();
  }

  Future<void> _commit() async {
    notifyListeners();
    await _storage.saveTasks(_tasks);
  }
}