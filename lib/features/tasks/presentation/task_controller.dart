import 'package:flutter/foundation.dart';
import '../../../core/storage/task_storage.dart';
import '../data/task_model.dart';

class TaskController extends ChangeNotifier {
  TaskController({TaskStorage? storage}) : _storage = storage ?? TaskStorage();

  final TaskStorage _storage;
  List<TaskModel> _tasks = [];
  bool _isLoading = true;

  List<TaskModel> get tasks => List.unmodifiable(_tasks);
  bool get isLoading => _isLoading;
  int get completedCount => _tasks.where((task) => task.isCompleted).length;
  int get totalCount => _tasks.length;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _tasks = await _storage.loadTasks();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(String title, double target, double remaining) async {
    final cleanTitle = title.trim();
    if (cleanTitle.isEmpty || target <= 0) return;

    final task = TaskModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: cleanTitle,
      target: target,
      remaining: remaining.clamp(0.0, target).toDouble(),
    );

    _tasks = [..._tasks, task];
    notifyListeners();
    await _save();
  }

  Future<void> updateTask(
    String id, {
    required String title,
    required double target,
    required double remaining,
  }) async {
    if (title.trim().isEmpty || target <= 0) return;

    final safeRemaining = remaining.clamp(0.0, target).toDouble();
    _tasks = _tasks.map((task) {
      if (task.id != id) return task;
      return task.copyWith(
        title: title.trim(),
        target: target,
        remaining: safeRemaining,
      );
    }).toList();

    notifyListeners();
    await _save();
  }

  Future<void> setRemaining(String id, double remaining) async {
    _tasks = _tasks.map((task) {
      if (task.id != id) return task;
      return task.copyWith(
        remaining: remaining.clamp(0.0, task.target).toDouble(),
      );
    }).toList();
    notifyListeners();
    await _save();
  }

  Future<void> toggleTask(String id) async {
    _tasks = _tasks.map((task) {
      if (task.id != id) return task;
      return task.copyWith(remaining: task.isCompleted ? task.target : 0.0);
    }).toList();
    notifyListeners();
    await _save();
  }

  Future<void> deleteTask(String id) async {
    _tasks = _tasks.where((task) => task.id != id).toList();
    notifyListeners();
    await _save();
  }

  Future<void> restoreTask(TaskModel task) async {
    if (_tasks.any((item) => item.id == task.id)) return;
    _tasks = [..._tasks, task];
    notifyListeners();
    await _save();
  }

  Future<void> resetAll() async {
    _tasks = _tasks
        .map((task) => task.copyWith(remaining: task.target))
        .toList();
    notifyListeners();
    await _save();
  }

  Future<void> _save() => _storage.saveTasks(_tasks);
}