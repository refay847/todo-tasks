/// Smallest amount a task can be increased or decreased by.
const double kAmountStep = 0.25;

/// True when [value] is a multiple of [kAmountStep] (0, 0.25, 0.5, 0.75, 1 ...).
/// Quarter steps are exact in binary floating point, so this check is safe.
bool isOnAmountStep(double value) {
  final steps = value / kAmountStep;
  return steps == steps.roundToDouble();
}

/// Formats 2.0 -> "2", 2.5 -> "2.5", 2.25 -> "2.25".
String formatAmount(double value) {
  var text = value.toStringAsFixed(2);
  text = text.replaceFirst(RegExp(r'0+$'), '');
  text = text.replaceFirst(RegExp(r'\.$'), '');
  return text;
}

class TaskModel {
  final String id;
  final String title;
  final double target;
  final double remaining;

  /// Drafts are kept out of the active list and out of the progress stats.
  final bool isDraft;

  const TaskModel({
    required this.id,
    required this.title,
    required this.target,
    required this.remaining,
    this.isDraft = false,
  });

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
    bool? isDraft,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      target: target ?? this.target,
      remaining: remaining ?? this.remaining,
      isDraft: isDraft ?? this.isDraft,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'target': target,
        'remaining': remaining,
        'isDraft': isDraft,
      };

  /// Backward compatible: old saves have no `isDraft` (defaults to false)
  /// and int values load fine as doubles.
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final remaining = ((json['remaining'] as num?)?.toDouble() ?? 0.0)
        .clamp(0.0, 999999.0)
        .toDouble();
    final target = (json['target'] as num?)?.toDouble() ?? remaining;

    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      target: target,
      remaining: remaining,
      isDraft: json['isDraft'] as bool? ?? false,
    );
  }
}