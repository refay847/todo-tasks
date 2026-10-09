import 'package:flutter/material.dart';
import '../data/task_model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    required this.onIncrease,
    required this.onDecrease,
  });

  final TaskModel task;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accent = task.isCompleted ? const Color(0xFF2E9B69) : colorScheme.primary;

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        onDelete();
        return false;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE8E8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Color(0xFFD83B3B)),
      ),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onEdit,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 14, 14),
            child: Column(
              children: [
                Row(
                  children: [
                    _CheckButton(
                      completed: task.isCompleted,
                      color: accent,
                      onTap: onToggle,
                    ),
                    const SizedBox(width: 12),
                    _RemainingControl(
                      task: task,
                      accent: accent,
                      onIncrease: onIncrease,
                      onDecrease: onDecrease,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            task.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 17,
                              height: 1.25,
                              fontWeight: FontWeight.w700,
                              color: task.isCompleted
                                  ? const Color(0xFF8A8D98)
                                  : const Color(0xFF20212A),
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            task.isCompleted
                                ? 'Completed'
                                : '${formatAmount(task.target - task.remaining)} of ${formatAmount(task.target)} done',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: task.isCompleted ? accent : const Color(0xFF9295A1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      tooltip: 'More options',
                      onSelected: (value) {
                        if (value == 'edit') onEdit();
                        if (value == 'delete') onDelete();
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.edit_outlined),
                            title: Text('Edit task'),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.delete_outline_rounded),
                            title: Text('Delete task'),
                          ),
                        ),
                      ],
                      icon: const Icon(Icons.more_horiz_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    value: task.progress,
                    backgroundColor: const Color(0xFFEDEEF3),
                    valueColor: AlwaysStoppedAnimation<Color>(accent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckButton extends StatelessWidget {
  const _CheckButton({required this.completed, required this.color, required this.onTap});

  final bool completed;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: completed ? 'Mark task incomplete' : 'Mark task complete',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: completed ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: completed ? color : const Color(0xFFD3D5DE), width: 2),
          ),
          child: Icon(
            Icons.check_rounded,
            size: 27,
            color: completed ? Colors.white : Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class _RemainingControl extends StatelessWidget {
  const _RemainingControl({
    required this.task,
    required this.accent,
    required this.onIncrease,
    required this.onDecrease,
  });

  final TaskModel task;
  final Color accent;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: accent.withValues(alpha: .10),
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: onDecrease,
            borderRadius: BorderRadius.circular(15),
            child: const SizedBox(
              width: 48,
              height: 27,
              child: Icon(Icons.remove_rounded, size: 18),
            ),
          ),
        ),
        Container(
          width: 56,
          height: 44,
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              formatAmount(task.remaining),
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ),
        ),
        Material(
          color: accent.withValues(alpha: .10),
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: onIncrease,
            borderRadius: BorderRadius.circular(15),
            child: const SizedBox(
              width: 48,
              height: 27,
              child: Icon(Icons.add_rounded, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}