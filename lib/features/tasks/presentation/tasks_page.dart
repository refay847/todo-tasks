import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/task_model.dart';
import 'task_controller.dart';
import 'task_tile.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late final TaskController _controller;
  late final TabController _tabController;

  TaskCategory get _currentCategory =>
      TaskCategory.values[_tabController.index];

  @override
  void initState() {
    super.initState();
    _controller = TaskController()..load();
    _tabController = TabController(
      length: TaskCategory.values.length,
      vsync: this,
    )..addListener(() {
        if (!_tabController.indexIsChanging) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _showSnack(String message, {SnackBarAction? action}) {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Future<void> _openTaskSheet({TaskModel? task}) async {
    final isEditing = task != null;
    final openedFromDraft = !isEditing && _currentCategory.isDraft;

    // Draft is not a real home category, so new tasks default to Work.
    final initialCategory = isEditing
        ? task.category
        : (openedFromDraft ? TaskCategory.work : _currentCategory);

    final titleController = TextEditingController(text: task?.title ?? '');
    final targetController = TextEditingController(
      text: formatAmount(task?.target ?? 1),
    );
    final remainingController = TextEditingController(
      text: formatAmount(task?.remaining ?? 1),
    );

    final result = await showModalBottomSheet<_TaskFormResult>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => _TaskFormSheet(
        isEditing: isEditing,
        openedFromDraft: openedFromDraft,
        initialCategory: initialCategory,
        initialStep: task?.step ?? kAmountStep,
        titleController: titleController,
        targetController: targetController,
        remainingController: remainingController,
      ),
    );

    titleController.dispose();
    targetController.dispose();
    remainingController.dispose();

    if (!mounted || result == null) return;

    if (isEditing) {
      await _controller.updateTask(
        task.id,
        title: result.title,
        target: result.target,
        remaining: result.remaining,
        category: result.category,
        step: result.step,
      );
    } else {
      await _controller.addTask(
        title: result.title,
        target: result.target,
        remaining: result.remaining,
        category: result.category,
        step: result.step,
      );
      // If added while viewing Draft (or to another tab), jump to that tab.
      if (result.category != _currentCategory) {
        _tabController.animateTo(result.category.index);
        _showSnack('Added to ${result.category.label}');
      }
    }
  }

  Future<bool> _confirmDeleteDialog(TaskModel task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete this task?'),
        content: Text('"${task.title}" will be removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  Future<void> _performDelete(TaskModel task) async {
    final deleted = await _controller.deleteTask(task.id);
    if (deleted == null) return;

    _showSnack(
      '"${deleted.task.title}" deleted',
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () => _controller.insertTaskAt(deleted.task, deleted.index),
      ),
    );
  }

  Future<void> _handleDraftOrRestore(TaskModel task) async {
    if (task.isDraft) {
      final restoredTo = await _controller.restoreFromDraft(task.id);
      if (restoredTo != null) {
        _showSnack(
          'Restored to ${restoredTo.label}',
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () => _controller.sendToDraft(task.id),
          ),
        );
      }
    } else {
      final previous = task.category;
      await _controller.sendToDraft(task.id);
      _showSnack(
        'Sent to Draft',
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () => _controller.moveTask(task.id, previous),
        ),
      );
    }
  }

  Future<void> _openMoveSheet(TaskModel task) async {
    final chosen = await showModalBottomSheet<TaskCategory>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) => _MoveCategorySheet(currentCategory: task.category),
    );

    if (!mounted || chosen == null || chosen == task.category) return;

    final previous = task.category;
    await _controller.moveTask(task.id, chosen);
    _showSnack(
      'Moved to ${chosen.label}',
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () => _controller.moveTask(task.id, previous),
      ),
    );
  }

  Future<void> _confirmResetCategory() async {
    final category = _currentCategory;
    if (_controller.countFor(category) == 0) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Reset ${category.label} progress?'),
        content: const Text(
          'Every task in this tab will return to its full target amount.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _controller.resetCategory(category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final currentCount = _controller.countFor(_currentCategory);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Focus Tasks',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            actions: [
              IconButton(
                tooltip: 'Reset ${_currentCategory.label} progress',
                onPressed: currentCount == 0 ? null : _confirmResetCategory,
                icon: const Icon(Icons.restart_alt_rounded),
              ),
              const SizedBox(width: 4),
            ],
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorWeight: 3,
              dividerHeight: 1,
              tabs: [
                for (final category in TaskCategory.values)
                  _CategoryTab(
                    category: category,
                    count: _controller.countFor(category),
                    selected: _currentCategory == category,
                  ),
              ],
            ),
          ),
          body: _controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                  controller: _tabController,
                  children: [
                    for (final category in TaskCategory.values)
                      _CategoryTaskList(
                        category: category,
                        controller: _controller,
                        onEdit: (task) => _openTaskSheet(task: task),
                        onMove: _openMoveSheet,
                        onDraftOrRestore: _handleDraftOrRestore,
                        onConfirmDelete: _confirmDeleteDialog,
                        onDeleteConfirmed: _performDelete,
                      ),
                  ],
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openTaskSheet(),
            backgroundColor: _currentCategory.color,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.add_rounded),
            label: const Text(
              'Add task',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        );
      },
    );
  }
}

class _CategoryTab extends StatelessWidget {
  const _CategoryTab({
    required this.category,
    required this.count,
    required this.selected,
  });

  final TaskCategory category;
  final int count;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final fg = selected ? category.color : colorScheme.onSurfaceVariant;

    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(category.icon, size: 18, color: fg),
          const SizedBox(width: 6),
          Text(
            category.label,
            style: TextStyle(
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: fg,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
            decoration: BoxDecoration(
              color: fg.withValues(alpha: selected ? 0.16 : 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: fg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTaskList extends StatelessWidget {
  const _CategoryTaskList({
    required this.category,
    required this.controller,
    required this.onEdit,
    required this.onMove,
    required this.onDraftOrRestore,
    required this.onConfirmDelete,
    required this.onDeleteConfirmed,
  });

  final TaskCategory category;
  final TaskController controller;
  final ValueChanged<TaskModel> onEdit;
  final ValueChanged<TaskModel> onMove;
  final ValueChanged<TaskModel> onDraftOrRestore;
  final Future<bool> Function(TaskModel) onConfirmDelete;
  final ValueChanged<TaskModel> onDeleteConfirmed;

  Widget _buildTile(TaskModel task, int index, {required bool reorderable}) {
    return Padding(
      key: ValueKey('task_${task.id}'),
      padding: const EdgeInsets.only(bottom: 10),
      child: TaskTile(
        task: task,
        index: index,
        reorderable: reorderable,
        onToggle: () => controller.toggleTask(task.id),
        onEdit: () => onEdit(task),
        onMove: () => onMove(task),
        onDraftOrRestore: () => onDraftOrRestore(task),
        onConfirmDelete: () => onConfirmDelete(task),
        onDeleteConfirmed: () => onDeleteConfirmed(task),
        onIncrease: () =>
            controller.setRemaining(task.id, task.remaining + task.step),
        onDecrease: () =>
            controller.setRemaining(task.id, task.remaining - task.step),
      ),
    );
  }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Material(
        color: Colors.transparent,
        elevation: Curves.easeOut.transform(animation.value) * 6,
        borderRadius: BorderRadius.circular(18),
        child: child,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final all = controller.tasksFor(category);
    final pending = controller.pendingTasksFor(category);
    final completed = controller.completedTasksFor(category);

    return Center(
      child: ConstrainedBox(
        // Keeps layout comfortable on tablets and wide screens.
        constraints: const BoxConstraints(maxWidth: 720),
        child: RefreshIndicator(
          onRefresh: controller.load,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 108),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    if (all.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: _CategoryEmptyState(category: category),
                      )
                    else ...[
                      if (!category.isDraft)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: _CategoryProgressBanner(
                              category: category,
                              completed: completed.length,
                              total: all.length,
                            ),
                          ),
                        )
                      else
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              'Drafts are paused. Use the menu to restore a task to its original tab.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ),
                        ),
                      if (category.isDraft)
                        SliverReorderableList(
                          itemCount: all.length,
                          proxyDecorator: _proxyDecorator,
                          onReorder: (oldIndex, newIndex) =>
                              controller.reorderCategory(
                            category,
                            oldIndex,
                            newIndex,
                          ),
                          itemBuilder: (_, i) =>
                              _buildTile(all[i], i, reorderable: true),
                        )
                      else ...[
                        if (pending.isNotEmpty)
                          SliverReorderableList(
                            itemCount: pending.length,
                            proxyDecorator: _proxyDecorator,
                            onReorder: (oldIndex, newIndex) =>
                                controller.reorderCategory(
                              category,
                              oldIndex,
                              newIndex,
                            ),
                            itemBuilder: (_, i) =>
                                _buildTile(pending[i], i, reorderable: true),
                          ),
                        if (completed.isNotEmpty) ...[
                          SliverToBoxAdapter(
                            child: _SectionLabel(
                              title: 'COMPLETED',
                              count: completed.length,
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, i) => _buildTile(
                                completed[i],
                                i,
                                reorderable: false,
                              ),
                              childCount: completed.length,
                            ),
                          ),
                        ],
                      ],
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryProgressBanner extends StatelessWidget {
  const _CategoryProgressBanner({
    required this.category,
    required this.completed,
    required this.total,
  });

  final TaskCategory category;
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : completed / total;
    final color = category.color;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.80)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(category.icon, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    value: progress,
                    backgroundColor: Colors.white.withValues(alpha: 0.24),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$completed of $total completed',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              '${(progress * 100).round()}%',
              key: ValueKey((progress * 100).round()),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryEmptyState extends StatelessWidget {
  const _CategoryEmptyState({required this.category});

  final TaskCategory category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = category.color;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(category.icon, size: 38, color: color),
            ),
            const SizedBox(height: 18),
            Text(
              category.isDraft ? 'No drafts yet' : 'No tasks here yet',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.isDraft
                  ? 'Send any task to Draft from its menu to pause it here.'
                  : 'Tap "Add task" below to create your first ${category.label} task.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title, required this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 2, right: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          Text(
            '$count ${count == 1 ? 'task' : 'tasks'}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoveCategorySheet extends StatelessWidget {
  const _MoveCategorySheet({required this.currentCategory});

  final TaskCategory currentCategory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                'Move task to...',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 4),
            for (final category in TaskCategory.values)
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                enabled: category != currentCategory,
                leading: CircleAvatar(
                  backgroundColor: category.color.withValues(
                    alpha: category == currentCategory ? 0.08 : 0.16,
                  ),
                  child: Icon(
                    category.icon,
                    size: 20,
                    color: category == currentCategory
                        ? colorScheme.onSurfaceVariant.withValues(alpha: 0.45)
                        : category.color,
                  ),
                ),
                title: Text(
                  category.label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: category == currentCategory
                    ? Text(
                        'Current',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      )
                    : const Icon(Icons.chevron_right_rounded),
                onTap: () => Navigator.pop(context, category),
              ),
          ],
        ),
      ),
    );
  }
}

class _TaskFormResult {
  const _TaskFormResult({
    required this.title,
    required this.target,
    required this.remaining,
    required this.category,
    required this.step,
  });

  final String title;
  final double target;
  final double remaining;
  final TaskCategory category;
  final double step;
}

class _TaskFormSheet extends StatefulWidget {
  const _TaskFormSheet({
    required this.isEditing,
    required this.openedFromDraft,
    required this.initialCategory,
    required this.initialStep,
    required this.titleController,
    required this.targetController,
    required this.remainingController,
  });

  final bool isEditing;
  final bool openedFromDraft;
  final TaskCategory initialCategory;
  final double initialStep;
  final TextEditingController titleController;
  final TextEditingController targetController;
  final TextEditingController remainingController;

  @override
  State<_TaskFormSheet> createState() => _TaskFormSheetState();
}

class _TaskFormSheetState extends State<_TaskFormSheet> {
  String? _error;
  late TaskCategory _selectedCategory = widget.initialCategory;
  late double _step = widget.initialStep;

  double? _parseAmount(String text) =>
      double.tryParse(text.trim().replaceAll(',', '.'));

  void _changeStep(double delta) {
    final clamped = (_step + delta).clamp(kMinStep, kMaxStep).toDouble();
    final rounded = (clamped / kAmountStep).round() * kAmountStep;
    setState(() => _step = rounded.clamp(kMinStep, kMaxStep).toDouble());
  }

  void _submit() {
    final title = widget.titleController.text.trim();
    final target = _parseAmount(widget.targetController.text);
    final remaining = widget.isEditing
        ? _parseAmount(widget.remainingController.text)
        : target;

    if (title.isEmpty) {
      setState(() => _error = 'Please enter a task title.');
      return;
    }
    if (target == null || target <= 0) {
      setState(() => _error = 'Total must be greater than 0.');
      return;
    }
    if (!isOnAmountStep(target)) {
      setState(() => _error = 'Total must be in steps of 0.25 (e.g. 1, 1.5).');
      return;
    }
    if (remaining == null || remaining < 0 || remaining > target) {
      setState(
        () => _error =
            'Remaining must be between 0 and ${formatAmount(target)}.',
      );
      return;
    }
    if (!isOnAmountStep(remaining)) {
      setState(
        () => _error = 'Remaining must be in steps of 0.25 (e.g. 0, 0.25).',
      );
      return;
    }

    Navigator.pop(
      context,
      _TaskFormResult(
        title: title,
        target: target,
        remaining: remaining,
        category: _selectedCategory,
        step: _step,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final availableCategories = widget.isEditing
        ? TaskCategory.values
        : TaskCategory.homeCategories;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          4,
          20,
          MediaQuery.viewInsetsOf(context).bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.isEditing ? 'Edit task' : 'New task',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.openedFromDraft
                  ? 'Draft is not a home tab — pick the category this task belongs to.'
                  : widget.isEditing
                      ? 'Update the title, amounts, or category.'
                      : 'Add a task to ${_selectedCategory.label}.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: widget.titleController,
              autofocus: !widget.isEditing,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Task title',
                prefixIcon: Icon(Icons.task_alt_rounded),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.targetController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Total',
                      prefixIcon: Icon(Icons.flag_outlined),
                    ),
                  ),
                ),
                if (widget.isEditing) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: widget.remainingController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Remaining',
                        prefixIcon: Icon(Icons.hourglass_bottom_rounded),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Hours per tap',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'How much the + and - buttons on the task change the remaining amount.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Decrease step',
                    onPressed: _step <= kMinStep
                        ? null
                        : () => _changeStep(-kAmountStep),
                    icon: const Icon(Icons.remove_rounded),
                  ),
                  Expanded(
                    child: Text(
                      '${formatAmount(_step)} h',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Increase step',
                    onPressed: _step >= kMaxStep
                        ? null
                        : () => _changeStep(kAmountStep),
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Category',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final cat in availableCategories)
                  ChoiceChip(
                    avatar: Icon(
                      cat.icon,
                      size: 16,
                      color: _selectedCategory == cat
                          ? Colors.white
                          : cat.color,
                    ),
                    label: Text(cat.label),
                    selected: _selectedCategory == cat,
                    selectedColor: cat.color,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _selectedCategory == cat
                          ? Colors.white
                          : colorScheme.onSurface,
                    ),
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                  ),
              ],
            ),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(
                _error!,
                style: TextStyle(
                  color: colorScheme.error,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: _submit,
              style: FilledButton.styleFrom(
                backgroundColor: _selectedCategory.color,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: Icon(
                widget.isEditing ? Icons.check_rounded : Icons.add_rounded,
              ),
              label: Text(widget.isEditing ? 'Save changes' : 'Create task'),
            ),
          ],
        ),
      ),
    );
  }
}