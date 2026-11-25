import 'package:flutter/foundation.dart';
import '../../../core/storage/task_storage.dart';
import '../data/task_model.dart';

/// Snapshot returned by [TaskController.deleteCategory] so the delete can be
/// undone with [TaskController.restoreDeletedCategory].
typedef DeletedCategory = ({
  TaskCategory category,
  int index,
  List<String> movedTaskIds,
});

/// Holds all tasks and all user categories (plus the fixed Draft category).
/// Position in the task list represents priority within each category.
class TaskController extends ChangeNotifier {
  TaskController({TaskStorage? storage})
      : _storage = storage ?? const TaskStorage();

  final TaskStorage _storage;
  List<TaskModel> _tasks = [];
  List<TaskCategory> _categories = List.of(TaskCategory.defaults);
  bool _isLoading = true;
  int _idCounter = 0;

  bool get isLoading => _isLoading;

  List<TaskModel> get allTasks => List.unmodifiable(_tasks);

  // -----------------------------------------------------------------------
  // Category queries
  // -----------------------------------------------------------------------

  /// User categories only (never contains Draft). Always has at least one.
  List<TaskCategory> get categories => List.unmodifiable(_categories);

  /// Every tab in display order: user categories, then Draft.
  List<TaskCategory> get allCategories => [..._categories, TaskCategory.draft];

  TaskCategory? categoryById(String id) {
    if (id == TaskCategory.draftId) return TaskCategory.draft;
    for (final category in _categories) {
      if (category.id == id) return category;
    }
    return null;
  }

  /// Category a drafted task returns to. Falls back to the first category if
  /// the original one no longer exists.
  TaskCategory restoreCategoryFor(TaskModel task) {
    final previousId = task.previousCategoryId;
    if (previousId != null) {
      final previous = categoryById(previousId);
      if (previous != null && !previous.isDraft) return previous;
    }
    return _categories.first;
  }

  /// True when [name] is empty, reserved, or already used by another category.
  bool isCategoryNameTaken(String name, {String? exceptId}) {
    final clean = name.trim().toLowerCase();
    if (clean.isEmpty) return true;
    if (clean == TaskCategory.draft.name.toLowerCase()) return true;
    return _categories.any(
      (c) => c.id != exceptId && c.name.toLowerCase() == clean,
    );
  }

  // -----------------------------------------------------------------------
  // Task queries
  // -----------------------------------------------------------------------

  List<TaskModel> tasksFor(TaskCategory category) =>
      List.unmodifiable(_tasks.where((t) => t.categoryId == category.id));

  List<TaskModel> pendingTasksFor(TaskCategory category) => List.unmodifiable(
        _tasks.where((t) => t.categoryId == category.id && !t.isCompleted),
      );

  List<TaskModel> completedTasksFor(TaskCategory category) =>
      List.unmodifiable(
        _tasks.where((t) => t.categoryId == category.id && t.isCompleted),
      );

  int countFor(TaskCategory category) =>
      _tasks.where((t) => t.categoryId == category.id).length;

  int completedCountFor(TaskCategory category) => _tasks
      .where((t) => t.categoryId == category.id && t.isCompleted)
      .length;

  String _generateId() {
    _idCounter += 1;
    return '${DateTime.now().microsecondsSinceEpoch}_$_idCounter';
  }

  // -----------------------------------------------------------------------
  // Loading
  // -----------------------------------------------------------------------

  /// [showLoading] is false for pull-to-refresh: showing the full-screen
  /// spinner there would replace (and rebuild) the whole TabBarView.
  Future<void> load({bool showLoading = true}) async {
    if (showLoading) {
      _isLoading = true;
      notifyListeners();
    }

    _categories = await _storage.loadCategories();
    _tasks = await _storage.loadTasks();

    // Safety net: a task pointing at a category that no longer exists is
    // parked in Draft instead of silently disappearing.
    final knownIds = _categories.map((c) => c.id).toSet();
    var repaired = false;
    _tasks = _tasks.map((t) {
      if (t.isDraft || knownIds.contains(t.categoryId)) return t;
      repaired = true;
      return t.copyWith(
        categoryId: TaskCategory.draftId,
        clearPreviousCategory: true,
      );
    }).toList();

    _isLoading = false;
    notifyListeners();

    if (repaired) await _storage.saveTasks(_tasks);
  }

  // -----------------------------------------------------------------------
  // Category CRUD
  // -----------------------------------------------------------------------

  /// Creates a category. Returns null if the name is empty or already taken.
  Future<TaskCategory?> addCategory({
    required String name,
    required String iconKey,
    required int colorValue,
  }) async {
    final cleanName = name.trim();
    if (isCategoryNameTaken(cleanName)) return null;

    final category = TaskCategory(
      id: 'cat_${_generateId()}',
      name: cleanName,
      iconKey: kCategoryIcons.containsKey(iconKey)
          ? iconKey
          : kDefaultCategoryIconKey,
      colorValue: colorValue,
    );

    _categories = [..._categories, category];
    await _commitAll();
    return category;
  }

  /// Renames / restyles a category. Tasks keep pointing at it by id.
  Future<bool> updateCategory(
    String id, {
    required String name,
    required String iconKey,
    required int colorValue,
  }) async {
    final cleanName = name.trim();
    if (isCategoryNameTaken(cleanName, exceptId: id)) return false;

    final index = _categories.indexWhere((c) => c.id == id);
    if (index < 0) return false;

    final list = [..._categories];
    list[index] = list[index].copyWith(
      name: cleanName,
      iconKey: kCategoryIcons.containsKey(iconKey)
          ? iconKey
          : kDefaultCategoryIconKey,
      colorValue: colorValue,
    );
    _categories = list;
    await _commitCategories();
    return true;
  }

  /// Deletes a category. Its tasks are moved to Draft (remembering the
  /// original category) so nothing is lost. The last remaining category can't
  /// be deleted. Returns a snapshot for UNDO, or null if nothing was deleted.
  Future<DeletedCategory?> deleteCategory(String id) async {
    if (_categories.length <= 1) return null;
    final index = _categories.indexWhere((c) => c.id == id);
    if (index < 0) return null;

    final removed = _categories[index];
    final movedIds = <String>[];

    _tasks = _tasks.map((t) {
      if (t.categoryId != id) return t;
      movedIds.add(t.id);
      return t.copyWith(
        categoryId: TaskCategory.draftId,
        previousCategoryId: id,
      );
    }).toList();

    _categories = [..._categories]..removeAt(index);
    await _commitAll();

    return (category: removed, index: index, movedTaskIds: movedIds);
  }

  /// Undoes [deleteCategory]: re-adds the category at its old position and
  /// moves its tasks back out of Draft.
  Future<void> restoreDeletedCategory(DeletedCategory deleted) async {
    if (_categories.any((c) => c.id == deleted.category.id)) return;

    final list = [..._categories];
    list.insert(deleted.index.clamp(0, list.length).toInt(), deleted.category);
    _categories = list;

    final movedIds = deleted.movedTaskIds.toSet();
    _tasks = _tasks.map((t) {
      final stillParked = movedIds.contains(t.id) &&
          t.isDraft &&
          t.previousCategoryId == deleted.category.id;
      if (!stillParked) return t;
      return t.copyWith(
        categoryId: deleted.category.id,
        clearPreviousCategory: true,
      );
    }).toList();

    await _commitAll();
  }

  Future<void> reorderCategories(int oldIndex, int newIndex) async {
    if (oldIndex < 0 || oldIndex >= _categories.length) return;
    if (newIndex > oldIndex) newIndex -= 1;
    newIndex = newIndex.clamp(0, _categories.length - 1).toInt();
    if (newIndex == oldIndex) return;

    final list = [..._categories];
    list.insert(newIndex, list.removeAt(oldIndex));
    _categories = list;
    await _commitCategories();
  }

  // -----------------------------------------------------------------------
  // Task CRUD
  // -----------------------------------------------------------------------

  Future<void> addTask({
    required String title,
    required double target,
    required double remaining,
    required TaskCategory category,
    double step = kAmountStep,
  }) async {
    final cleanTitle = title.trim();
    if (cleanTitle.isEmpty || target <= 0) return;

    // Draft is not a real home category; fall back to the first category.
    final safeCategory = (category.isDraft || categoryById(category.id) == null)
        ? _categories.first
        : category;
    final safeStep = step.clamp(kMinStep, kMaxStep).toDouble();

    final task = TaskModel(
      id: _generateId(),
      title: cleanTitle,
      target: target,
      remaining: remaining.clamp(0.0, target).toDouble(),
      step: safeStep,
      categoryId: safeCategory.id,
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
    final nextCategoryId = category?.id ?? old.categoryId;
    final categoryChanged = nextCategoryId != old.categoryId;
    final safeStep = step?.clamp(kMinStep, kMaxStep).toDouble();

    String? nextPrevious = old.previousCategoryId;
    var clearPrevious = false;

    if (categoryChanged) {
      if (nextCategoryId == TaskCategory.draftId) {
        nextPrevious = old.isDraft ? old.previousCategoryId : old.categoryId;
      } else {
        clearPrevious = true;
      }
    }

    final updated = old.copyWith(
      title: cleanTitle,
      target: target,
      remaining: remaining.clamp(0.0, target).toDouble(),
      step: safeStep,
      categoryId: nextCategoryId,
      previousCategoryId: nextPrevious,
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
          previousCategoryId: current.categoryId,
          categoryId: TaskCategory.draftId,
        );
    _tasks = [...list, drafted];
    await _commit();
  }

  /// Restores a drafted task back to its previous category (fallback: first
  /// category if the original was deleted).
  Future<TaskCategory?> restoreFromDraft(String id) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index < 0) return null;

    final current = _tasks[index];
    if (!current.isDraft) return null;

    final target = restoreCategoryFor(current);
    final list = [..._tasks];
    final restored = list.removeAt(index).copyWith(
          categoryId: target.id,
          clearPreviousCategory: true,
        );
    _tasks = [...list, restored];
    await _commit();
    return target;
  }

  /// Moves a task to any other category. Moving to Draft remembers its origin;
  /// moving out of Draft clears `previousCategoryId`.
  Future<void> moveTask(String id, TaskCategory targetCategory) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index < 0) return;

    final current = _tasks[index];
    if (current.categoryId == targetCategory.id) return;

    if (targetCategory.isDraft) {
      await sendToDraft(id);
      return;
    }
    if (categoryById(targetCategory.id) == null) return;

    final list = [..._tasks];
    final moved = list.removeAt(index).copyWith(
          categoryId: targetCategory.id,
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
        ? (TaskModel t) => t.isDraft
        : (TaskModel t) => t.categoryId == category.id && !t.isCompleted;
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
      if (t.categoryId != category.id) return t;
      return t.copyWith(remaining: t.target);
    }).toList();
    await _commit();
  }

  // -----------------------------------------------------------------------
  // Persistence
  // -----------------------------------------------------------------------

  Future<void> _commit() async {
    notifyListeners();
    await _storage.saveTasks(_tasks);
  }

  Future<void> _commitCategories() async {
    notifyListeners();
    await _storage.saveCategories(_categories);
  }

  Future<void> _commitAll() async {
    notifyListeners();
    await _storage.saveCategories(_categories);
    await _storage.saveTasks(_tasks);
  }
}