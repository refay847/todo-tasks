import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'task_controller.dart';
import 'task_tile.dart';
import '../data/task_model.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late final TaskController _controller;
  int _tab = 0; // 0 = Tasks, 1 = Drafts

  @override
  void initState() {
    super.initState();
    _controller = TaskController()..load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openTaskSheet({TaskModel? task, bool startAsDraft = false}) async {
    final titleController = TextEditingController(text: task?.title ?? '');
    final targetController = TextEditingController(
      text: formatAmount(task?.target ?? 1),
    );
    // New tasks start with all the work remaining.
    final remainingController = TextEditingController(
      text: formatAmount(task?.remaining ?? 1),
    );

    final result = await showModalBottomSheet<_TaskFormResult>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (sheetContext) {
        return _TaskFormSheet(
          isEditing: task != null,
          initialDraft: task?.isDraft ?? startAsDraft,
          titleController: titleController,
          targetController: targetController,
          remainingController: remainingController,
        );
      },
    );

    titleController.dispose();
    targetController.dispose();
    remainingController.dispose();

    if (!mounted || result == null) return;

    if (task == null) {
      await _controller.addTask(
        result.title,
        result.target,
        result.remaining,
        isDraft: result.isDraft,
      );
    } else {
      await _controller.updateTask(
        task.id,
        title: result.title,
        target: result.target,
        remaining: result.remaining,
        isDraft: result.isDraft,
      );
    }
  }

  Future<void> _deleteTask(TaskModel task) async {
    await _controller.deleteTask(task.id);
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${task.title}" deleted'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () => _controller.restoreTask(task),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Future<void> _toggleDraft(TaskModel task) async {
    final toDraft = !task.isDraft;
    await _controller.setDraft(task.id, toDraft);
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(toDraft ? 'Moved to drafts' : 'Moved to tasks'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () => _controller.setDraft(task.id, task.isDraft),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Future<void> _confirmReset() async {
    if (_controller.totalCount == 0) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset all progress?'),
        content: const Text(
          'Every task will return to its original amount. Your task names and targets will stay unchanged.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset progress'),
          ),
        ],
      ),
    );

    if (confirmed == true) await _controller.resetAll();
  }

  Widget _buildItem(TaskModel task, int index, {bool reorderable = true}) {
    return Padding(
      key: ValueKey('item_${task.id}'),
      padding: const EdgeInsets.only(bottom: 10),
      child: TaskTile(
        task: task,
        index: index,
        reorderable: reorderable,
        onToggle: () => _controller.toggleTask(task.id),
        onEdit: () => _openTaskSheet(task: task),
        onDelete: () => _deleteTask(task),
        onToggleDraft: () => _toggleDraft(task),
        onIncrease: () => _controller.setRemaining(
          task.id,
          task.remaining + kAmountStep,
        ),
        onDecrease: () => _controller.setRemaining(
          task.id,
          task.remaining - kAmountStep,
        ),
      ),
    );
  }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Material(
        color: Colors.transparent,
        elevation: Curves.easeOut.transform(animation.value) * 8,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(20),
        child: child,
      ),
      child: child,
    );
  }

  List<Widget> _buildSlivers() {
    final pending = _controller.pendingTasks;
    final completedTasks = _controller.completedTasks;
    final drafts = _controller.draftTasks;
    final completed = completedTasks.length;
    final activeTotal = _controller.activeCount;
    final progress = activeTotal == 0 ? 0.0 : completed / activeTotal;

    return [
      SliverToBoxAdapter(
        child: _ProgressHeader(
          completed: completed,
          total: activeTotal,
          progress: progress,
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 14),
          child: _TabSwitcher(
            index: _tab,
            taskCount: activeTotal,
            draftCount: drafts.length,
            onChanged: (i) => setState(() => _tab = i),
          ),
        ),
      ),
      if (_tab == 0) ...[
        if (activeTotal == 0)
          const SliverToBoxAdapter(
            child: _InlineHint(
              text: 'No active tasks. Create one or move a draft here.',
            ),
          ),
        if (pending.length > 1)
          const SliverToBoxAdapter(
            child: _HintLine(
              'Drag the handle to set priority. Top = most important.',
            ),
          ),
        if (pending.isNotEmpty)
          SliverReorderableList(
            itemCount: pending.length,
            proxyDecorator: _proxyDecorator,
            onReorder: _controller.reorderPending,
            itemBuilder: (_, i) => _buildItem(pending[i], i),
          ),
        if (completedTasks.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: _SectionLabel(title: 'COMPLETED', count: completed),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => _buildItem(completedTasks[i], i, reorderable: false),
              childCount: completedTasks.length,
            ),
          ),
        ],
      ] else ...[
        if (drafts.isEmpty)
          const SliverToBoxAdapter(
            child: _InlineHint(
              text:
                  'No drafts yet.\nSwipe a task to the right to save it as a draft.',
            ),
          )
        else ...[
          const SliverToBoxAdapter(
            child: _HintLine(
              'Drafts are not counted in your progress. Swipe right to move one to your tasks.',
            ),
          ),
          SliverReorderableList(
            itemCount: drafts.length,
            proxyDecorator: _proxyDecorator,
            onReorder: _controller.reorderDrafts,
            itemBuilder: (_, i) => _buildItem(drafts[i], i),
          ),
        ],
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            titleSpacing: 20,
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Focus Tasks',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 2),
                Text(
                  'Make progress, one step at a time.',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: 'Reset progress',
                onPressed: _controller.totalCount == 0 ? null : _confirmReset,
                icon: const Icon(Icons.restart_alt_rounded),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: _controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _controller.totalCount == 0
                  ? const _EmptyState()
                  : RefreshIndicator(
                      onRefresh: _controller.load,
                      child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
                            sliver: SliverMainAxisGroup(slivers: _buildSlivers()),
                          ),
                        ],
                      ),
                    ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openTaskSheet(startAsDraft: _tab == 1),
            icon: const Icon(Icons.add_rounded),
            label: Text(
              _tab == 1 ? 'New draft' : 'New task',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        );
      },
    );
  }
}

class _TabSwitcher extends StatelessWidget {
  const _TabSwitcher({
    required this.index,
    required this.taskCount,
    required this.draftCount,
    required this.onChanged,
  });

  final int index;
  final int taskCount;
  final int draftCount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFECEDF3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _TabItem(
            label: 'Tasks',
            icon: Icons.checklist_rounded,
            count: taskCount,
            selected: index == 0,
            onTap: () => onChanged(0),
          ),
          _TabItem(
            label: 'Drafts',
            icon: Icons.drafts_outlined,
            count: draftCount,
            selected: index == 1,
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.icon,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final fg = selected ? primary : const Color(0xFF777A86);

    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: '$label, $count',
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
              color: selected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: fg),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: fg,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                  decoration: BoxDecoration(
                    color: fg.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: fg,
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title, required this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w800,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            '$count ${count == 1 ? 'task' : 'tasks'}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

class _HintLine extends StatelessWidget {
  const _HintLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 2),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
      ),
    );
  }
}

class _InlineHint extends StatelessWidget {
  const _InlineHint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF777A86)),
        ),
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({
    required this.completed,
    required this.total,
    required this.progress,
  });

  final int completed;
  final int total;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: .82)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: .18),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today’s progress',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Keep going.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 58,
                height: 58,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .16),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${(progress * 100).round()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: progress,
              backgroundColor: Colors.white.withValues(alpha: .20),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$completed of $total tasks completed',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .10),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.checklist_rounded, size: 42, color: color),
            ),
            const SizedBox(height: 22),
            const Text(
              'Nothing here yet',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Create a task and set how much work is left.\nYou can change it anytime.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.5, color: Color(0xFF777A86)),
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
    required this.isDraft,
  });

  final String title;
  final double target;
  final double remaining;
  final bool isDraft;
}

class _TaskFormSheet extends StatefulWidget {
  const _TaskFormSheet({
    required this.isEditing,
    required this.initialDraft,
    required this.titleController,
    required this.targetController,
    required this.remainingController,
  });

  final bool isEditing;
  final bool initialDraft;
  final TextEditingController titleController;
  final TextEditingController targetController;
  final TextEditingController remainingController;

  @override
  State<_TaskFormSheet> createState() => _TaskFormSheetState();
}

class _TaskFormSheetState extends State<_TaskFormSheet> {
  String? _error;
  late bool _isDraft = widget.initialDraft;

  /// Accepts "1.5" and "1,5" (some keyboards use a comma).
  double? _parseAmount(String text) =>
      double.tryParse(text.trim().replaceAll(',', '.'));

  void _submit() {
    final title = widget.titleController.text.trim();
    final target = _parseAmount(widget.targetController.text);
    // When creating, all the work is still remaining, so remaining == total.
    final remaining = widget.isEditing
        ? _parseAmount(widget.remainingController.text)
        : target;

    if (title.isEmpty) {
      setState(() => _error = 'Enter a task name.');
      return;
    }
    if (target == null || target <= 0) {
      setState(() => _error = 'Total must be greater than 0.');
      return;
    }
    if (!isOnAmountStep(target)) {
      setState(() => _error = 'Total must be in steps of 0.25 (e.g. 1, 1.25, 1.5).');
      return;
    }
    if (remaining == null || remaining < 0 || remaining > target) {
      setState(() =>
          _error = 'Remaining must be between 0 and ${formatAmount(target)}.');
      return;
    }
    if (!isOnAmountStep(remaining)) {
      setState(() =>
          _error = 'Remaining must be in steps of 0.25 (e.g. 0, 0.25, 0.5).');
      return;
    }

    Navigator.pop(
      context,
      _TaskFormResult(
        title: title,
        target: target,
        remaining: remaining,
        isDraft: _isDraft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              widget.isEditing ? 'Edit task' : 'Create a task',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              widget.isEditing
                  ? 'Update the name, target, or remaining work.'
                  : 'Set the total amount of work you want to finish.',
              style: const TextStyle(color: Color(0xFF777A86)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: widget.titleController,
              autofocus: !widget.isEditing,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Task name',
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
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _isDraft,
              onChanged: (v) => setState(() => _isDraft = v),
              title: const Text(
                'Save as draft',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                'Drafts stay out of your progress until you move them to tasks.',
                style: TextStyle(fontSize: 12),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 4),
              Text(
                _error!,
                style: const TextStyle(
                  color: Color(0xFFD83B3B),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.isEditing ? Icons.check_rounded : Icons.add_rounded),
              label: Text(widget.isEditing ? 'Save changes' : 'Create task'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}