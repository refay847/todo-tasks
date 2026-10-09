import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/tasks/data/task_model.dart';

class TaskStorage {
  /// Each independent list uses its own [key].
  /// The default keeps existing saved tasks working.
  const TaskStorage({this.key = 'tasks'});

  final String key;

  Future<List<TaskModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);

    if (raw == null || raw.isEmpty) {
      return [];
    }

    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((item) => TaskModel.fromJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(key, raw);
  }

  Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}