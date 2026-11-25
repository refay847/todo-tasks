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

// ---------------------------------------------------------------------------
// Category appearance options
// ---------------------------------------------------------------------------

const String kDefaultCategoryIconKey = 'folder';

/// Icons are stored by key (never by code point) so they stay const and
/// tree-shakeable. `draft` is reserved for the built-in Draft category.
const Map<String, IconData> kCategoryIcons = {
  'religion': Icons.auto_stories_rounded,
  'work': Icons.work_outline_rounded,
  'learn': Icons.school_outlined,
  'college': Icons.account_balance_outlined,
  'family': Icons.favorite_outline_rounded,
  'draft': Icons.drafts_outlined,
  'folder': Icons.folder_outlined,
  'home': Icons.home_outlined,
  'health': Icons.health_and_safety_outlined,
  'fitness': Icons.fitness_center_rounded,
  'shopping': Icons.shopping_cart_outlined,
  'savings': Icons.savings_outlined,
  'travel': Icons.flight_takeoff_rounded,
  'code': Icons.code_rounded,
  'art': Icons.palette_outlined,
  'music': Icons.music_note_rounded,
  'games': Icons.sports_esports_outlined,
  'pets': Icons.pets_outlined,
  'food': Icons.restaurant_outlined,
  'car': Icons.directions_car_outlined,
  'group': Icons.group_outlined,
  'star': Icons.star_outline_rounded,
  'idea': Icons.lightbulb_outline_rounded,
  'mind': Icons.self_improvement_rounded,
  'book': Icons.menu_book_outlined,
};

/// Icon keys a user can pick from (everything except the reserved draft icon).
final List<String> kPickableCategoryIconKeys = [
  for (final key in kCategoryIcons.keys)
    if (key != 'draft') key,
];

const List<int> kCategoryColors = [
  0xFF4F46E5,
  0xFF0F9D8A,
  0xFFD97706,
  0xFF2563EB,
  0xFFDB2777,
  0xFFDC2626,
  0xFF16A34A,
  0xFF7C3AED,
  0xFF0891B2,
  0xFFEA580C,
  0xFF65A30D,
];

// ---------------------------------------------------------------------------
// Category
// ---------------------------------------------------------------------------

/// A user-editable task category. Tasks reference categories by [id], so
/// renaming or restyling a category never breaks saved tasks.
///
/// [draft] is a built-in, fixed category that always appears as the last tab.
@immutable
class TaskCategory {
  const TaskCategory({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.colorValue,
  });

  static const String draftId = 'draft';

  // Default categories keep the same ids the old enum used as `name`, so
  // tasks saved by earlier versions map straight onto them.
  static const TaskCategory religion = TaskCategory(
    id: 'religion',
    name: 'Religion',
    iconKey: 'religion',
    colorValue: 0xFF0F9D8A,
  );
  static const TaskCategory work = TaskCategory(
    id: 'work',
    name: 'Work',
    iconKey: 'work',
    colorValue: 0xFF4F46E5,
  );
  static const TaskCategory learn = TaskCategory(
    id: 'learn',
    name: 'Learn',
    iconKey: 'learn',
    colorValue: 0xFFD97706,
  );
  static const TaskCategory college = TaskCategory(
    id: 'college',
    name: 'College',
    iconKey: 'college',
    colorValue: 0xFF2563EB,
  );
  static const TaskCategory family = TaskCategory(
    id: 'family',
    name: 'Family',
    iconKey: 'family',
    colorValue: 0xFFDB2777,
  );
  static const TaskCategory draft = TaskCategory(
    id: draftId,
    name: 'Draft',
    iconKey: 'draft',
    colorValue: 0xFF64748B,
  );

  /// Categories created on first launch (in display order).
  static const List<TaskCategory> defaults = [
    religion,
    work,
    learn,
    college,
    family,
  ];

  final String id;
  final String name;
  final String iconKey;
  final int colorValue;

  bool get isDraft => id == draftId;

  String get label => name;

  IconData get icon =>
      kCategoryIcons[iconKey] ?? kCategoryIcons[kDefaultCategoryIconKey]!;

  Color get color => Color(colorValue);

  TaskCategory copyWith({String? name, String? iconKey, int? colorValue}) {
    return TaskCategory(
      id: id,
      name: name ?? this.name,
      iconKey: iconKey ?? this.iconKey,
      colorValue: colorValue ?? this.colorValue,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': iconKey,
        'color': colorValue,
      };

  /// Returns null for malformed entries (and for the reserved draft id).
  static TaskCategory? tryFromJson(Object? raw) {
    if (raw is! Map) return null;
    final id = raw['id']?.toString().trim() ?? '';
    final name = (raw['name'] as String?)?.trim() ?? '';
    if (id.isEmpty || name.isEmpty || id == draftId) return null;

    final rawIcon = raw['icon'];
    final iconKey = (rawIcon is String && kCategoryIcons.containsKey(rawIcon))
        ? rawIcon
        : kDefaultCategoryIconKey;
    final rawColor = raw['color'];
    final colorValue = rawColor is int ? rawColor : kCategoryColors.first;

    return TaskCategory(
      id: id,
      name: name,
      iconKey: iconKey,
      colorValue: colorValue,
    );
  }

  @override
  bool operator ==(Object other) => other is TaskCategory && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

// ---------------------------------------------------------------------------
// Task
// ---------------------------------------------------------------------------

class TaskModel {
  final String id;
  final String title;
  final double target;
  final double remaining;
  final double step;

  /// Id of the [TaskCategory] this task lives in (or [TaskCategory.draftId]).
  final String categoryId;

  /// Remembers the category id a task came from when moved into Draft.
  final String? previousCategoryId;

  const TaskModel({
    required this.id,
    required this.title,
    required this.target,
    required this.remaining,
    this.step = kAmountStep,
    this.categoryId = 'work',
    this.previousCategoryId,
  });

  bool get isDraft => categoryId == TaskCategory.draftId;

  bool get isCompleted => remaining <= 0;

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
    String? categoryId,
    String? previousCategoryId,
    bool clearPreviousCategory = false,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      target: target ?? this.target,
      remaining: remaining ?? this.remaining,
      step: step ?? this.step,
      categoryId: categoryId ?? this.categoryId,
      previousCategoryId: clearPreviousCategory
          ? null
          : (previousCategoryId ?? this.previousCategoryId),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'target': target,
        'remaining': remaining,
        'step': step,
        'category': categoryId,
        'previousCategory': previousCategoryId,
      };

  /// Backward compatible with old saves: the old enum `name` values
  /// (`work`, `family`, ...) are exactly the default category ids, and very
  /// old saves that only stored `isDraft` are still understood.
  factory TaskModel.fromJson(
    Map<String, dynamic> json, {
    String defaultCategoryId = 'work',
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

    final rawCategory = (json['category'] as String?)?.trim();
    final legacyIsDraft = json['isDraft'] as bool? ?? false;

    final categoryId = (rawCategory != null && rawCategory.isNotEmpty)
        ? rawCategory
        : (legacyIsDraft ? TaskCategory.draftId : defaultCategoryId);

    final rawPrevious = (json['previousCategory'] as String?)?.trim();
    final previousCategoryId = categoryId == TaskCategory.draftId &&
            rawPrevious != null &&
            rawPrevious.isNotEmpty &&
            rawPrevious != TaskCategory.draftId
        ? rawPrevious
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
      categoryId: categoryId,
      previousCategoryId: previousCategoryId,
    );
  }
}