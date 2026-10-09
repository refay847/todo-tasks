/// Smallest amount a task can be increased or decreased by.
const double kAmountStep = 0.5;

/// Formats 2.0 -> "2" and 2.5 -> "2.5".
String formatAmount(double value) {
  return value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toStringAsFixed(1);
}

class TaskModel {
  final String id;
  final String title;
  final double target;
  final double remaining;

  const TaskModel({
    required this.id,
    required this.title,
    required this.target,
    required this.remaining,
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
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      target: target ?? this.target,
      remaining: remaining ?? this.remaining,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'target': target,
        'remaining': remaining,
      };

  /// Backward compatible: previously saved int values load fine as doubles.
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
    );
  }
}