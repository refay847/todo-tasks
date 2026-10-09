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

  Future<void> _openTaskSheet({TaskModel? task}) async {
    final titleController = TextEditingController(text: task?.title ?? '');
    final targetController = TextEditingController(
      text: formatAmount(task?.target ?? 1),
    );
    final remainingController = TextEditingController(
      text: formatAmount(task?.remaining ?? 0),
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
      await _controller.addTask(result.title, result.target, result.remaining);
    } else {
      await _controller.updateTask(
        task.id,
        title: result.title,
        target: result.target,
        remaining: result.remaining,
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

  Future<void> _confirmReset() async {
    if (_controller.tasks.isEmpty) return;

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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final completed = _controller.completedCount;
        final total = _controller.totalCount;
        final progress = total == 0 ? 0.0 : completed / total;

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
                onPressed: total == 0 ? null : _confirmReset,
                icon: const Icon(Icons.restart_alt_rounded),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: _controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : total == 0
                  ? const _EmptyState()
                  : RefreshIndicator(
                      onRefresh: _controller.load,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
                        children: [
                          _ProgressHeader(
                            completed: completed,
                            total: total,
                            progress: progress,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'YOUR TASKS',
                                style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                '$total ${total == 1 ? 'task' : 'tasks'}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ..._controller.tasks.map(
                            (task) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TaskTile(
                                task: task,
                                onToggle: () => _controller.toggleTask(task.id),
                                onEdit: () => _openTaskSheet(task: task),
                                onDelete: () => _deleteTask(task),
                                onIncrease: () => _controller.setRemaining(
                                  task.id,
                                  task.remaining + kAmountStep,
                                ),
                                onDecrease: () => _controller.setRemaining(
                                  task.id,
                                  task.remaining - kAmountStep,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openTaskSheet(),
            icon: const Icon(Icons.add_rounded),
            label: const Text(
              'New task',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        );
      },
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
  });

  final String title;
  final double target;
  final double remaining;
}

class _TaskFormSheet extends StatefulWidget {
  const _TaskFormSheet({
    required this.isEditing,
    required this.titleController,
    required this.targetController,
    required this.remainingController,
  });

  final bool isEditing;
  final TextEditingController titleController;
  final TextEditingController targetController;
  final TextEditingController remainingController;

  @override
  State<_TaskFormSheet> createState() => _TaskFormSheetState();
}

class _TaskFormSheetState extends State<_TaskFormSheet> {
  String? _error;

  /// Accepts "1.5" and "1,5" (some keyboards use a comma).
  double? _parseAmount(String text) =>
      double.tryParse(text.trim().replaceAll(',', '.'));

  /// True for 0, 0.5, 1, 1.5, ...
  bool _isHalfStep(double v) => (v * 2) == (v * 2).roundToDouble();

  void _submit() {
    final title = widget.titleController.text.trim();
    final target = _parseAmount(widget.targetController.text);
    final remaining = _parseAmount(widget.remainingController.text);

    if (title.isEmpty) {
      setState(() => _error = 'Enter a task name.');
      return;
    }
    if (target == null || target <= 0) {
      setState(() => _error = 'Total must be greater than 0.');
      return;
    }
    if (!_isHalfStep(target)) {
      setState(() => _error = 'Total must be in steps of 0.5 (e.g. 1, 1.5, 2).');
      return;
    }
    if (remaining == null || remaining < 0 || remaining > target) {
      setState(() =>
          _error = 'Remaining must be between 0 and ${formatAmount(target)}.');
      return;
    }
    if (!_isHalfStep(remaining)) {
      setState(
          () => _error = 'Remaining must be in steps of 0.5 (e.g. 0, 0.5, 1).');
      return;
    }

    Navigator.pop(
      context,
      _TaskFormResult(
        title: title,
        target: target,
        remaining: remaining,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          ),
          if (_error != null) ...[
            const SizedBox(height: 10),
            Text(
              _error!,
              style: const TextStyle(
                color: Color(0xFFD83B3B),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const SizedBox(height: 18),
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
    );
  }
}