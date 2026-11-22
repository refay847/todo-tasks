import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/tasks/data/task_model.dart';

class TaskStorage {
  const TaskStorage({
    this.key = 'tasks',
    this.legacyReligionKey = 'religion_tasks',
  });

  final String key;
  final String legacyReligionKey;

  Future<List<TaskModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = _decodeList(
      prefs.getString(key),
      defaultCategory: TaskCategory.work,
    );

    // One-time migration for tasks previously stored under `religion_tasks`.
    final legacyRaw = prefs.getString(legacyReligionKey);
    if (legacyRaw != null && legacyRaw.isNotEmpty) {
      final legacyReligion = _decodeList(
        legacyRaw,
        defaultCategory: TaskCategory.religion,
      );
      final existingIds = tasks.map((t) => t.id).toSet();
      var migrated = false;

      for (final item in legacyReligion) {
        if (!existingIds.contains(item.id)) {
          tasks.add(
            item.copyWith(
              category: TaskCategory.religion,
              clearPreviousCategory: true,
            ),
          );
          existingIds.add(item.id);
          migrated = true;
        }
      }

      if (migrated) {
        await saveTasks(tasks);
      }
      await prefs.remove(legacyReligionKey);
    }

    return tasks;
  }

  List<TaskModel> _decodeList(
    String? raw, {
    required TaskCategory defaultCategory,
  }) {
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return [];
      final result = <TaskModel>[];
      for (final item in decoded) {
        if (item is Map) {
          try {
            result.add(
              TaskModel.fromJson(
                Map<String, dynamic>.from(item),
                defaultCategory: defaultCategory,
              ),
            );
          } catch (_) {
            // Skip malformed entries rather than losing all saved tasks.
          }
        }
      }
      return result;
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
    await prefs.remove(legacyReligionKey);
  }
}