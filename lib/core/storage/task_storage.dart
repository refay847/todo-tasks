import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/tasks/data/task_model.dart';

class TaskStorage {
  const TaskStorage({
    this.key = 'tasks',
    this.legacyReligionKey = 'religion_tasks',
    this.categoriesKey = 'categories',
  });

  final String key;
  final String legacyReligionKey;
  final String categoriesKey;

  // ---------------------------------------------------------------------
  // Categories
  // ---------------------------------------------------------------------

  /// Returns the saved categories, or the defaults on first launch / when the
  /// saved data is missing or unreadable. Never returns an empty list.
  Future<List<TaskCategory>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(categoriesKey);
    if (raw == null || raw.isEmpty) return List.of(TaskCategory.defaults);

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return List.of(TaskCategory.defaults);

      final result = <TaskCategory>[];
      final seenIds = <String>{};
      for (final item in decoded) {
        final category = TaskCategory.tryFromJson(item);
        if (category != null && seenIds.add(category.id)) {
          result.add(category);
        }
      }
      return result.isEmpty ? List.of(TaskCategory.defaults) : result;
    } catch (_) {
      return List.of(TaskCategory.defaults);
    }
  }

  Future<void> saveCategories(List<TaskCategory> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(categories.map((c) => c.toJson()).toList());
    await prefs.setString(categoriesKey, raw);
  }

  // ---------------------------------------------------------------------
  // Tasks
  // ---------------------------------------------------------------------

  Future<List<TaskModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = _decodeList(
      prefs.getString(key),
      defaultCategoryId: TaskCategory.work.id,
    );

    // One-time migration for tasks previously stored under `religion_tasks`.
    final legacyRaw = prefs.getString(legacyReligionKey);
    if (legacyRaw != null && legacyRaw.isNotEmpty) {
      final legacyReligion = _decodeList(
        legacyRaw,
        defaultCategoryId: TaskCategory.religion.id,
      );
      final existingIds = tasks.map((t) => t.id).toSet();
      var migrated = false;

      for (final item in legacyReligion) {
        if (!existingIds.contains(item.id)) {
          tasks.add(
            item.copyWith(
              categoryId: TaskCategory.religion.id,
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
    required String defaultCategoryId,
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
                defaultCategoryId: defaultCategoryId,
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