import 'package:flutter/material.dart';
import '../data/task_model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.index,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    required this.onIncrease,
    required this.onDecrease,
    required this.onToggleDraft,
    this.reorderable = true,
    this.allowDraft = true,
  });

  final TaskModel task;

  /// Index inside its reorderable list (needed by the drag handle).
  final int index;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  /// Moves the task to Drafts (if active) or publishes it (if a draft).
  final VoidCallback onToggleDraft;

  /// Finished tasks are pinned to the bottom, so they have no drag handle.
  final bool reorderable;

  /// When false (e.g. the Religion list) the task can't be moved to drafts:
  /// the swipe-right action and the menu entry are removed.
  final bool allowDraft;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accent = task.isDraft
        ? const Color(0xFF8A8D98)
        : task.isCompleted
            ? const Color(0xFF2E9B69)
            : colorScheme.primary;

    final subtitle = task.isDraft
        ? 'Draft · ${formatAmount(task.target - task.remaining)} of ${formatAmount(task.target)} done'
        : task.isCompleted
            ? 'Completed'
            : '${formatAmount(task.target - task.remaining)} of ${formatAmount(task.target)} done';

    const deleteBackground = _SwipeBackground(
      alignment: Alignment.centerRight,
      color: Color(0xFFFFE8E8),
      foreground: Color(0xFFD83B3B),
      icon: Icons.delete_outline_rounded,
      label: 'Delete',
    );

    return Dismissible(
      key: ValueKey(task.id),
      direction: allowDraft
          ? DismissDirection.horizontal
          : DismissDirection.endToStart,
      // Left -> right: move to drafts (or back to tasks). Right -> left: delete.
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onToggleDraft();
        } else {
          onDelete();
        }
        return false;
      },
      // Dismissible requires a background whenever secondaryBackground is set.
      background: allowDraft
          ? _SwipeBackground(
              alignment: Alignment.centerLeft,
              color: colorScheme.primary.withValues(alpha: .10),
              foreground: colorScheme.primary,
              icon: task.isDraft
                  ? Icons.publish_rounded
                  : Icons.drafts_outlined,
              label: task.isDraft ? 'Move to tasks' : 'Move to drafts',
            )
          : deleteBackground,
      secondaryBackground: deleteBackground,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onEdit,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(2, 12, 14, 14),
            child: Column(
              children: [
                Row(
                  children: [
                    if (reorderable)
                      ReorderableDragStartListener(
                        index: index,
                        child: Semantics(
                          label: 'Drag to change priority',
                          child: const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                            child: Icon(
                              Icons.drag_indicator_rounded,
                              color: Color(0xFFB3B6C2),
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(width: 14),
                    if (task.isDraft)
                      _PublishButton(onTap: onToggleDraft)
                    else
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
                              color: task.isCompleted || task.isDraft
                                  ? const Color(0xFF8A8D98)
                                  : const Color(0xFF20212A),
                              decoration: task.isCompleted && !task.isDraft
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: task.isCompleted && !task.isDraft
                                  ? accent
                                  : const Color(0xFF9295A1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      tooltip: 'More options',
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            onEdit();
                          case 'draft':
                            onToggleDraft();
                          case 'delete':
                            onDelete();
                        }
                      },
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.edit_outlined),
                            title: Text('Edit task'),
                          ),
                        ),
                        if (allowDraft)
                          PopupMenuItem(
                            value: 'draft',
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(task.isDraft
                                  ? Icons.publish_rounded
                                  : Icons.drafts_outlined),
                              title: Text(task.isDraft
                                  ? 'Move to tasks'
                                  : 'Move to drafts'),
                            ),
                          ),
                        const PopupMenuItem(
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
                Padding(
                  padding: EdgeInsets.only(left: reorderable ? 12 : 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      minHeight: 6,
                      value: task.progress,
                      backgroundColor: const Color(0xFFEDEEF3),
                      valueColor: AlwaysStoppedAnimation<Color>(accent),
                    ),
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

class _SwipeBackground extends StatelessWidget {
  const _SwipeBackground({
    required this.alignment,
    required this.color,
    required this.foreground,
    required this.icon,
    required this.label,
  });

  final Alignment alignment;
  final Color color;
  final Color foreground;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final leading = alignment == Alignment.centerLeft;
    final iconWidget = Icon(icon, color: foreground);
    final text = Text(
      label,
      style: TextStyle(
        color: foreground,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: leading
            ? [iconWidget, const SizedBox(width: 8), text]
            : [text, const SizedBox(width: 8), iconWidget],
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

/// Shown instead of the check button on drafts: moves the task to the active list.
class _PublishButton extends StatelessWidget {
  const _PublishButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Move draft to tasks',
      child: Tooltip(
        message: 'Move to tasks',
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFD3D5DE), width: 2),
            ),
            child: const Icon(
              Icons.publish_rounded,
              size: 24,
              color: Color(0xFF8A8D98),
            ),
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