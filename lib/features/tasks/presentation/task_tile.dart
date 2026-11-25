import 'package:flutter/material.dart';
import '../data/task_model.dart';

enum _TileMenuAction { edit, move, draftOrRestore, delete }

/// A single task card.
///
/// Note: there is intentionally no horizontal swipe gesture on the tile any
/// more, so horizontal swipes fall through to the category `TabBarView`.
/// Deleting is done from the tile's menu (the page asks for confirmation).
class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.category,
    required this.restoreCategory,
    required this.index,
    required this.onToggle,
    required this.onEdit,
    required this.onMove,
    required this.onDraftOrRestore,
    required this.onDelete,
    required this.onIncrease,
    required this.onDecrease,
    this.reorderable = true,
  });

  final TaskModel task;

  /// The category this task currently lives in (Draft for drafted tasks).
  final TaskCategory category;

  /// Where the task goes when restored from Draft.
  final TaskCategory restoreCategory;

  final int index;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onMove;
  final VoidCallback onDraftOrRestore;
  final VoidCallback onDelete;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final bool reorderable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final categoryColor = category.color;
    final accent = task.isCompleted && !task.isDraft
        ? const Color(0xFF16A34A)
        : categoryColor;

    final doneAmount = formatAmount(task.target - task.remaining);
    final totalAmount = formatAmount(task.target);
    final subtitle = task.isDraft
        ? 'Returns to: ${restoreCategory.label} · $doneAmount / $totalAmount'
        : task.isCompleted
            ? 'Completed'
            : '$doneAmount of $totalAmount done';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onEdit,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Colored left accent bar matching the task's category.
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 5,
                color: accent,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 12, 8, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          if (reorderable)
                            ReorderableDragStartListener(
                              index: index,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 10,
                                ),
                                child: Icon(
                                  Icons.drag_indicator_rounded,
                                  size: 20,
                                  color: colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                            )
                          else
                            const SizedBox(width: 8),
                          _CheckButton(
                            completed: task.isCompleted,
                            color: accent,
                            onTap: onToggle,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    height: 1.25,
                                    color: task.isCompleted
                                        ? colorScheme.onSurfaceVariant
                                        : colorScheme.onSurface,
                                    decoration: task.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  subtitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: task.isCompleted && !task.isDraft
                                        ? accent
                                        : colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          _RemainingControl(
                            task: task,
                            accent: accent,
                            onIncrease: onIncrease,
                            onDecrease: onDecrease,
                          ),
                          _TaskMenuButton(
                            task: task,
                            restoreCategory: restoreCategory,
                            onSelected: (action) {
                              switch (action) {
                                case _TileMenuAction.edit:
                                  onEdit();
                                case _TileMenuAction.move:
                                  onMove();
                                case _TileMenuAction.draftOrRestore:
                                  onDraftOrRestore();
                                case _TileMenuAction.delete:
                                  onDelete();
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            minHeight: 5,
                            value: task.progress,
                            backgroundColor:
                                colorScheme.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation<Color>(accent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskMenuButton extends StatelessWidget {
  const _TaskMenuButton({
    required this.task,
    required this.restoreCategory,
    required this.onSelected,
  });

  final TaskModel task;
  final TaskCategory restoreCategory;
  final ValueChanged<_TileMenuAction> onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopupMenuButton<_TileMenuAction>(
      tooltip: 'Task actions',
      icon: Icon(
        Icons.more_vert_rounded,
        color: colorScheme.onSurfaceVariant,
      ),
      onSelected: onSelected,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: _TileMenuAction.edit,
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 20),
              SizedBox(width: 12),
              Text('Edit'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: _TileMenuAction.move,
          child: Row(
            children: [
              Icon(Icons.drive_file_move_outlined, size: 20),
              SizedBox(width: 12),
              Text('Move to...'),
            ],
          ),
        ),
        PopupMenuItem(
          value: _TileMenuAction.draftOrRestore,
          child: Row(
            children: [
              Icon(
                task.isDraft ? Icons.restore_rounded : Icons.drafts_outlined,
                size: 20,
                color: task.isDraft ? restoreCategory.color : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(task.isDraft ? 'Restore' : 'Send to draft'),
                    if (task.isDraft)
                      Text(
                        'Returns to: ${restoreCategory.label}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: _TileMenuAction.delete,
          child: Row(
            children: [
              Icon(
                Icons.delete_outline_rounded,
                size: 20,
                color: colorScheme.error,
              ),
              const SizedBox(width: 12),
              Text(
                'Delete',
                style: TextStyle(color: colorScheme.error),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CheckButton extends StatelessWidget {
  const _CheckButton({
    required this.completed,
    required this.color,
    required this.onTap,
  });

  final bool completed;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final outline = Theme.of(context).colorScheme.outlineVariant;

    return Semantics(
      button: true,
      checked: completed,
      label: completed ? 'Mark task incomplete' : 'Mark task complete',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: completed ? color : Colors.transparent,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: completed ? color : outline,
                width: 2,
              ),
            ),
            child: Icon(
              Icons.check_rounded,
              size: 19,
              color: completed ? Colors.white : Colors.transparent,
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
    return Container(
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepIconButton(
            icon: Icons.remove_rounded,
            tooltip: 'Decrease remaining by ${formatAmount(task.step)}',
            onTap: onDecrease,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 28, maxWidth: 46),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  formatAmount(task.remaining),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                ),
              ),
            ),
          ),
          _StepIconButton(
            icon: Icons.add_rounded,
            tooltip: 'Increase remaining by ${formatAmount(task.step)}',
            onTap: onIncrease,
          ),
        ],
      ),
    );
  }
}

class _StepIconButton extends StatelessWidget {
  const _StepIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 30,
          height: 34,
          child: Icon(icon, size: 16),
        ),
      ),
    );
  }
}