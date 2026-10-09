import 'package:flutter/foundation.dart';
import '../../../core/storage/task_storage.dart';
import '../data/task_model.dart';

/// Priority is the position in the persisted list: index 0 is the most important.
/// Active tasks and drafts live in one list; each group keeps its own order.
///
/// Finished tasks are only *displayed* at the bottom of the Tasks tab
/// ([pendingTasks] then [completedTasks]). The stored order is never touched
/// by completing a task, so un-completing it or pressing "Reset" puts every
/// task back at its original priority.
class TaskController extends ChangeNotifier {
  TaskController({TaskStorage? storage}) : _storage = storage ?? TaskStorage();

  final TaskStorage _storage;
  List<TaskModel> _tasks = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<TaskModel> get activeTasks => _group(draft: false);
  List<TaskModel> get draftTasks => _group(draft: true);

  /// Unfinished active tasks, in priority order (drag-and-drop list).
  List<TaskModel> get pendingTasks => List.unmodifiable(
      _tasks.where((t) => !t.isDraft && !t.isCompleted));

  /// Finished active tasks, shown below the pending ones.
  List<TaskModel> get completedTasks => List.unmodifiable(
      _tasks.where((t) => !t.isDraft && t.isCompleted));

  int get totalCount => _tasks.length;
  int get activeCount => _tasks.where((t) => !t.isDraft).length;
  int get draftCount => _tasks.where((t) => t.isDraft).length;
  int get completedCount =>
      _tasks.where((t) => !t.isDraft && t.isCompleted).length;

  List<TaskModel> _group({required bool draft}) =>
      List.unmodifiable(_tasks.where((t) => t.isDraft == draft));

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _tasks = await _storage.loadTasks();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(
    String title,
    double target,
    double remaining, {
    bool isDraft = false,
  }) async {
    final cleanTitle = title.trim();
    if (cleanTitle.isEmpty || target <= 0) return;

    final task = TaskModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: cleanTitle,
      target: target,
      remaining: remaining.clamp(0.0, target).toDouble(),
      isDraft: isDraft,
    );

    _tasks = [..._tasks, task];
    await _commit();
  }

  Future<void> updateTask(
    String id, {
    required String title,
    required double target,
    required double remaining,
    bool? isDraft,
  }) async {
    if (title.trim().isEmpty || target <= 0) return;

    final index = _tasks.indexWhere((t) => t.id == id);
    if (index < 0) return;

    final old = _tasks[index];
    final updated = old.copyWith(
      title: title.trim(),
      target: target,
      remaining: remaining.clamp(0.0, target).toDouble(),
      isDraft: isDraft,
    );

    final list = [..._tasks];
    if (updated.isDraft != old.isDraft) {
      // Switching group: goes to the end (lowest priority) of the new group.
      list
        ..removeAt(index)
        ..add(updated);
    } else {
      list[index] = updated;
    }
    _tasks = list;
    await _commit();
  }

  /// Moves a task between Active and Drafts (to the end of the target group).
  Future<void> setDraft(String id, bool isDraft) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index < 0 || _tasks[index].isDraft == isDraft) return;

    final list = [..._tasks];
    final task = list.removeAt(index).copyWith(isDraft: isDraft);
    _tasks = [...list, task];
    await _commit();
  }

  /// Reorders the unfinished tasks. Indexes follow [ReorderableList.onReorder]
  /// (newIndex is not yet adjusted). Finished tasks keep their stored slots.
  Future<void> reorderPending(int oldIndex, int newIndex) =>
      _reorderGroup((t) => !t.isDraft && !t.isCompleted, oldIndex, newIndex);

  Future<void> reorderDrafts(int oldIndex, int newIndex) =>
      _reorderGroup((t) => t.isDraft, oldIndex, newIndex);

  /// Reorders the tasks matching [inGroup] by re-filling the slots they
  /// occupy, so every task outside the group stays exactly where it was.
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

  Future<void> deleteTask(String id) async {
    _tasks = _tasks.where((task) => task.id != id).toList();
    await _commit();
  }

  Future<void> restoreTask(TaskModel task) async {
    if (_tasks.any((item) => item.id == task.id)) return;
    _tasks = [..._tasks, task];
    await _commit();
  }

  Future<void> resetAll() async {
    _tasks = _tasks.map((t) => t.copyWith(remaining: t.target)).toList();
    await _commit();
  }

  Future<void> _commit() async {
    notifyListeners();
    await _storage.saveTasks(_tasks);
  }
}