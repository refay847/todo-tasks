import 'package:flutter/material.dart';

/// Smallest amount a task can be increased or decreased by.
const double kAmountStep = 0.25;
const double kMinStep = 0.25;
const double kMaxStep = 24.0;

/// True when [value] is a multiple of [step] (0, 0.25, 0.5, 0.75, 1 ...).
bool isOnAmountStep(double value, {double step = kAmountStep}) {
  final steps = value / step;
  return (steps - steps.roundToDouble()).abs() < 1e-9;
}

/// Formats 2.0 -> "2", 2.5 -> "2.5", 2.25 -> "2.25".
String formatAmount(double value) {
  var text = value.toStringAsFixed(2);
  text = text.replaceFirst(RegExp(r'0+$'), '');
  text = text.replaceFirst(RegExp(r'\.$'), '');
  return text;
}

/// The 6 app tabs in exact display order.
enum TaskCategory {
  religion,
  work,
  learn,
  college,
  family,
  draft;

  /// All real (non-draft) categories a task can live in.
  static const List<TaskCategory> homeCategories = [
    TaskCategory.religion,
    TaskCategory.work,
    TaskCategory.learn,
    TaskCategory.college,
    TaskCategory.family,
  ];

  bool get isDraft => this == TaskCategory.draft;

  String get label => switch (this) {
        TaskCategory.religion => 'Religion',
        TaskCategory.work => 'Work',
        TaskCategory.learn => 'Learn',
        TaskCategory.college => 'College',
        TaskCategory.family => 'Family',
        TaskCategory.draft => 'Draft',
      };

  IconData get icon => switch (this) {
        TaskCategory.religion => Icons.auto_stories_rounded,
        TaskCategory.work => Icons.work_outline_rounded,
        TaskCategory.learn => Icons.school_outlined,
        TaskCategory.college => Icons.account_balance_outlined,
        TaskCategory.family => Icons.favorite_outline_rounded,
        TaskCategory.draft => Icons.drafts_outlined,
      };

  Color get color => switch (this) {
        TaskCategory.religion => const Color(0xFF0F9D8A),
        TaskCategory.work => const Color(0xFF4F46E5),
        TaskCategory.learn => const Color(0xFFD97706),
        TaskCategory.college => const Color(0xFF2563EB),
        TaskCategory.family => const Color(0xFFDB2777),
        TaskCategory.draft => const Color(0xFF64748B),
      };

  static TaskCategory? fromName(String? name) {
    if (name == null || name.isEmpty) return null;
    for (final value in TaskCategory.values) {
      if (value.name == name) return value;
    }
    return null;
  }
}

class TaskModel {
  final String id;
  final String title;
  final double target;
  final double remaining;
  final double step;
  final TaskCategory category;

  /// Remembers the home category a task came from when moved into Draft.
  final TaskCategory? previousCategory;

  const TaskModel({
    required this.id,
    required this.title,
    required this.target,
    required this.remaining,
    this.step = kAmountStep,
    this.category = TaskCategory.work,
    this.previousCategory,
  });

  bool get isDraft => category == TaskCategory.draft;

  bool get isCompleted => remaining <= 0;

  /// Category this task returns to when restored from Draft.
  TaskCategory get restoreCategory {
    final prev = previousCategory;
    if (prev == null || prev.isDraft) return TaskCategory.work;
    return prev;
  }

  double get progress {
    if (target <= 0) return 1;
    return ((target - remaining) / target).clamp(0.0, 1.0).toDouble();
  }

  TaskModel copyWith({
    String? id,
    String? title,
    double? target,
    double? remaining,
    double? step,
    TaskCategory? category,
    TaskCategory? previousCategory,
    bool clearPreviousCategory = false,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      target: target ?? this.target,
      remaining: remaining ?? this.remaining,
      step: step ?? this.step,
      category: category ?? this.category,
      previousCategory: clearPreviousCategory
          ? null
          : (previousCategory ?? this.previousCategory),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'target': target,
        'remaining': remaining,
        'step': step,
        'category': category.name,
        'previousCategory': previousCategory?.name,
      };

  /// Backward compatible with old saves that only stored `isDraft` and had no
  /// `category` or `previousCategory`.
  factory TaskModel.fromJson(
    Map<String, dynamic> json, {
    TaskCategory defaultCategory = TaskCategory.work,
  }) {
    final remaining = ((json['remaining'] as num?)?.toDouble() ?? 0.0)
        .clamp(0.0, 999999.0)
        .toDouble();
    final rawTarget = (json['target'] as num?)?.toDouble() ?? remaining;
    final target = rawTarget <= 0 ? (remaining > 0 ? remaining : 1.0) : rawTarget;

    final rawStep = (json['step'] as num?)?.toDouble();
    final step = (rawStep == null || rawStep.isNaN || rawStep <= 0)
        ? kAmountStep
        : rawStep.clamp(kMinStep, kMaxStep).toDouble();

    final parsedCategory = TaskCategory.fromName(json['category'] as String?);
    final legacyIsDraft = json['isDraft'] as bool? ?? false;

    final category = parsedCategory ??
        (legacyIsDraft ? TaskCategory.draft : defaultCategory);

    final parsedPrevious =
        TaskCategory.fromName(json['previousCategory'] as String?);
    final previousCategory =
        category.isDraft && parsedPrevious != null && !parsedPrevious.isDraft
            ? parsedPrevious
            : null;

    final rawId = json['id']?.toString().trim();
    final id = (rawId != null && rawId.isNotEmpty)
        ? rawId
        : DateTime.now().microsecondsSinceEpoch.toString();

    return TaskModel(
      id: id,
      title: (json['title'] as String?)?.trim() ?? 'Untitled task',
      target: target,
      remaining: remaining.clamp(0.0, target).toDouble(),
      step: step,
      category: category,
      previousCategory: previousCategory,
    );
  }
}