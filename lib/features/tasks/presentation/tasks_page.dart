import 'package:flutter/foundation.dart' show listEquals;
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

class _TasksPageState extends State<TasksPage> with TickerProviderStateMixin {
  late final TaskController _controller;

  /// Recreated whenever the set / order of categories changes, because a
  /// TabController has a fixed length.
  late TabController _tabController;
  late List<String> _tabIds;
  late String _selectedId;

  TaskCategory get _currentCategory {
    final all = _controller.allCategories;
    return all[_tabController.index.clamp(0, all.length - 1).toInt()];
  }

  @override
  void initState() {
    super.initState();
    _controller = TaskController();
    _tabIds = _controller.allCategories.map((c) => c.id).toList();
    _selectedId = _tabIds.first;
    _tabController = _createTabController(_tabIds.length, 0);
    // Added before load() and before any AnimatedBuilder subscribes, so the
    // tab controller is always in sync before the UI rebuilds.
    _controller.addListener(_onControllerChanged);
    _controller.load();
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  TabController _createTabController(int length, int index) {
    return TabController(length: length, vsync: this, initialIndex: index)
      ..addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    final index = _tabController.index;
    if (index < _tabIds.length) _selectedId = _tabIds[index];
    setState(() {});
  }

  /// Keeps the TabController's length in step with the category list and
  /// keeps the same category selected (or the nearest neighbour if the
  /// selected one was deleted).
  void _onControllerChanged() {
    final ids = _controller.allCategories.map((c) => c.id).toList();
    if (listEquals(ids, _tabIds)) return;

    var index = ids.indexOf(_selectedId);
    if (index < 0) {
      index = _tabController.index.clamp(0, ids.length - 1).toInt();
    }

    final old = _tabController;
    old.removeListener(_onTabChanged);
    _tabController = _createTabController(ids.length, index);
    _tabIds = ids;
    _selectedId = ids[index];

    // Dispose after the frame so the old TabBar/TabBarView detach cleanly.
    WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());
    setState(() {});
  }

  /// Animates to the tab for [categoryId] once the tab bar has been rebuilt.
  void _goToCategory(String categoryId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final index = _tabIds.indexOf(categoryId);
      if (index >= 0 && index != _tabController.index) {
        _tabController.animateTo(index);
      }
    });
    WidgetsBinding.instance.scheduleFrame();
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

  // -----------------------------------------------------------------------
  // Tasks
  // -----------------------------------------------------------------------

  Future<void> _openTaskSheet({TaskModel? task}) async {
    final isEditing = task != null;
    final current = _currentCategory;
    final openedFromDraft = !isEditing && current.isDraft;

    // Draft can only be picked while editing; new tasks go to a real category.
    final available =
        isEditing ? _controller.allCategories : _controller.categories;

    // Draft is not a home category, so new tasks from Draft default to the
    // first category.
    final initialCategory = isEditing
        ? (_controller.categoryById(task.categoryId) ?? available.first)
        : (openedFromDraft ? _controller.categories.first : current);

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
        categories: available,
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
      if (result.category != current) {
        _goToCategory(result.category.id);
        _showSnack('Added to ${result.category.label}');
      }
    }
  }

  /// Delete is only reachable from the task menu now (no swipe), and always
  /// asks first. UNDO restores the task at its old position.
  Future<void> _deleteTask(TaskModel task) async {
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
    if (confirmed != true) return;

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
      final previous =
          _controller.categoryById(task.categoryId) ?? _controller.categories.first;
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
    final current =
        _controller.categoryById(task.categoryId) ?? TaskCategory.draft;

    final chosen = await showModalBottomSheet<TaskCategory>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) => _MoveCategorySheet(
        categories: _controller.allCategories,
        currentCategory: current,
      ),
    );

    if (!mounted || chosen == null || chosen == current) return;

    await _controller.moveTask(task.id, chosen);
    _showSnack(
      'Moved to ${chosen.label}',
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () => _controller.moveTask(task.id, current),
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

  // -----------------------------------------------------------------------
  // Categories (create / edit / delete)
  // -----------------------------------------------------------------------

  Future<void> _openManageCategories() {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => _ManageCategoriesSheet(
        controller: _controller,
        onCreate: _createCategory,
        onEdit: _editCategory,
        onDelete: _deleteCategory,
      ),
    );
  }

  String? _validateCategoryName(String name, {String? exceptId}) {
    final clean = name.trim();
    if (clean.isEmpty) return 'Please enter a category name.';
    if (_controller.isCategoryNameTaken(clean, exceptId: exceptId)) {
      return clean.toLowerCase() == TaskCategory.draft.name.toLowerCase()
          ? '"Draft" is reserved for the built-in Draft tab.'
          : 'A category with this name already exists.';
    }
    return null;
  }

  Future<_CategoryFormResult?> _openCategoryForm({TaskCategory? category}) {
    return showModalBottomSheet<_CategoryFormResult>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => _CategoryFormSheet(
        initial: category,
        validateName: (name) =>
            _validateCategoryName(name, exceptId: category?.id),
      ),
    );
  }

  Future<void> _createCategory() async {
    final result = await _openCategoryForm();
    if (!mounted || result == null) return;

    final created = await _controller.addCategory(
      name: result.name,
      iconKey: result.iconKey,
      colorValue: result.colorValue,
    );
    if (created != null) _goToCategory(created.id);
  }

  Future<void> _editCategory(TaskCategory category) async {
    final result = await _openCategoryForm(category: category);
    if (!mounted || result == null) return;

    await _controller.updateCategory(
      category.id,
      name: result.name,
      iconKey: result.iconKey,
      colorValue: result.colorValue,
    );
  }

  /// Returns true when the category was actually deleted.
  Future<bool> _deleteCategory(TaskCategory category) async {
    if (_controller.categories.length <= 1) {
      _showSnack('You need at least one category.');
      return false;
    }

    final count = _controller.countFor(category);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Delete "${category.label}"?'),
        content: Text(
          count == 0
              ? 'This category is empty and will be removed.'
              : '$count ${count == 1 ? 'task' : 'tasks'} will be moved to '
                  'Draft so nothing is lost.',
        ),
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
    if (confirmed != true) return false;

    final deleted = await _controller.deleteCategory(category.id);
    if (deleted == null) return false;

    _showSnack(
      '"${category.label}" deleted',
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () => _controller.restoreDeletedCategory(deleted),
      ),
    );
    return true;
  }

  // -----------------------------------------------------------------------
  // Build
  // -----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final tabs = _controller.allCategories;
        final current = _currentCategory;
        final currentCount = _controller.countFor(current);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Focus Tasks',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            actions: [
              IconButton(
                tooltip: 'Manage categories',
                onPressed: _controller.isLoading ? null : _openManageCategories,
                icon: const Icon(Icons.category_outlined),
              ),
              IconButton(
                tooltip: 'Reset ${current.label} progress',
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
                for (final category in tabs)
                  _CategoryTab(
                    category: category,
                    count: _controller.countFor(category),
                    selected: current == category,
                  ),
              ],
            ),
          ),
          // Horizontal swipes on the page move between categories.
          body: _controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                  controller: _tabController,
                  children: [
                    for (final category in tabs)
                      _CategoryTaskList(
                        key: ValueKey('list_${category.id}'),
                        category: category,
                        controller: _controller,
                        onEdit: (task) => _openTaskSheet(task: task),
                        onMove: _openMoveSheet,
                        onDraftOrRestore: _handleDraftOrRestore,
                        onDelete: _deleteTask,
                      ),
                  ],
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openTaskSheet(),
            backgroundColor: current.color,
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
    super.key,
    required this.category,
    required this.controller,
    required this.onEdit,
    required this.onMove,
    required this.onDraftOrRestore,
    required this.onDelete,
  });

  final TaskCategory category;
  final TaskController controller;
  final ValueChanged<TaskModel> onEdit;
  final ValueChanged<TaskModel> onMove;
  final ValueChanged<TaskModel> onDraftOrRestore;
  final ValueChanged<TaskModel> onDelete;

  Widget _buildTile(TaskModel task, int index, {required bool reorderable}) {
    return Padding(
      key: ValueKey('task_${task.id}'),
      padding: const EdgeInsets.only(bottom: 10),
      child: TaskTile(
        task: task,
        category: category,
        restoreCategory: controller.restoreCategoryFor(task),
        index: index,
        reorderable: reorderable,
        onToggle: () => controller.toggleTask(task.id),
        onEdit: () => onEdit(task),
        onMove: () => onMove(task),
        onDraftOrRestore: () => onDraftOrRestore(task),
        onDelete: () => onDelete(task),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
  const _MoveCategorySheet({
    required this.categories,
    required this.currentCategory,
  });

  final List<TaskCategory> categories;
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
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final category in categories)
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
                              ? colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.45)
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
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Category management UI
// ---------------------------------------------------------------------------

class _ManageCategoriesSheet extends StatelessWidget {
  const _ManageCategoriesSheet({
    required this.controller,
    required this.onCreate,
    required this.onEdit,
    required this.onDelete,
  });

  final TaskController controller;
  final Future<void> Function() onCreate;
  final Future<void> Function(TaskCategory) onEdit;
  final Future<bool> Function(TaskCategory) onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Rebuilds live while categories are created / edited / reordered.
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final categories = controller.categories;
        final canDelete = categories.length > 1;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Categories',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      FilledButton.tonalIcon(
                        onPressed: onCreate,
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('New'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                  child: Text(
                    'Drag to reorder tabs. Deleting a category moves its tasks to Draft.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Flexible(
                  child: ReorderableListView(
                    shrinkWrap: true,
                    buildDefaultDragHandles: false,
                    onReorder: controller.reorderCategories,
                    children: [
                      for (var i = 0; i < categories.length; i++)
                        ListTile(
                          key: ValueKey('manage_${categories[i].id}'),
                          contentPadding: const EdgeInsets.only(left: 8),
                          leading: CircleAvatar(
                            backgroundColor:
                                categories[i].color.withValues(alpha: 0.16),
                            child: Icon(
                              categories[i].icon,
                              size: 20,
                              color: categories[i].color,
                            ),
                          ),
                          title: Text(
                            categories[i].label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Builder(builder: (_) {
                            final count = controller.countFor(categories[i]);
                            return Text('$count ${count == 1 ? 'task' : 'tasks'}');
                          }),
                          onTap: () => onEdit(categories[i]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Edit',
                                onPressed: () => onEdit(categories[i]),
                                icon: const Icon(Icons.edit_outlined),
                              ),
                              IconButton(
                                tooltip: canDelete
                                    ? 'Delete'
                                    : 'At least one category is required',
                                onPressed: canDelete
                                    ? () async {
                                        final deleted =
                                            await onDelete(categories[i]);
                                        // Close the sheet so the UNDO snackbar
                                        // is visible.
                                        if (deleted && context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      }
                                    : null,
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: canDelete ? colorScheme.error : null,
                                ),
                              ),
                              ReorderableDragStartListener(
                                index: i,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 8,
                                  ),
                                  child: Icon(
                                    Icons.drag_indicator_rounded,
                                    color: colorScheme.onSurfaceVariant
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CategoryFormResult {
  const _CategoryFormResult({
    required this.name,
    required this.iconKey,
    required this.colorValue,
  });

  final String name;
  final String iconKey;
  final int colorValue;
}

class _CategoryFormSheet extends StatefulWidget {
  const _CategoryFormSheet({
    required this.initial,
    required this.validateName,
  });

  /// Null when creating a new category.
  final TaskCategory? initial;

  /// Returns an error message, or null when the name is acceptable.
  final String? Function(String name) validateName;

  @override
  State<_CategoryFormSheet> createState() => _CategoryFormSheetState();
}

class _CategoryFormSheetState extends State<_CategoryFormSheet> {
  static const int _maxNameLength = 24;

  late final TextEditingController _nameController =
      TextEditingController(text: widget.initial?.name ?? '');
  late String _iconKey = widget.initial?.iconKey ?? kDefaultCategoryIconKey;
  late int _colorValue = widget.initial?.colorValue ?? kCategoryColors.first;
  String? _error;

  bool get _isEditing => widget.initial != null;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    final error = widget.validateName(_nameController.text);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    Navigator.pop(
      context,
      _CategoryFormResult(
        name: _nameController.text.trim(),
        iconKey: _iconKey,
        colorValue: _colorValue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = Color(_colorValue);
    final icon = kCategoryIcons[_iconKey] ?? Icons.folder_outlined;

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
              _isEditing ? 'Edit category' : 'New category',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              autofocus: !_isEditing,
              maxLength: _maxNameLength,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
              onSubmitted: (_) => _submit(),
              buildCounter: (
                context, {
                required currentLength,
                required isFocused,
                maxLength,
              }) =>
                  null,
              decoration: InputDecoration(
                labelText: 'Category name',
                prefixIcon: Icon(icon, color: color),
                errorText: _error,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Icon',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final key in kPickableCategoryIconKeys)
                  _IconChoice(
                    icon: kCategoryIcons[key]!,
                    color: color,
                    selected: key == _iconKey,
                    onTap: () => setState(() => _iconKey = key),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Color',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final value in kCategoryColors)
                  _ColorChoice(
                    color: Color(value),
                    selected: value == _colorValue,
                    onTap: () => setState(() => _colorValue = value),
                  ),
              ],
            ),
            const SizedBox(height: 22),
            FilledButton.icon(
              onPressed: _submit,
              style: FilledButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: Icon(_isEditing ? Icons.check_rounded : Icons.add_rounded),
              label: Text(_isEditing ? 'Save changes' : 'Create category'),
            ),
            if (_isEditing) ...[
              const SizedBox(height: 6),
              Text(
                'Tasks in this category keep their place when you rename or restyle it.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _IconChoice extends StatelessWidget {
  const _IconChoice({
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.16)
              : colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          size: 22,
          color: selected ? color : colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ColorChoice extends StatelessWidget {
  const _ColorChoice({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.onSurface
                : Colors.transparent,
            width: 2.5,
          ),
        ),
        child: selected
            ? const Icon(Icons.check_rounded, size: 20, color: Colors.white)
            : null,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Task form
// ---------------------------------------------------------------------------

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
    required this.categories,
    required this.initialCategory,
    required this.initialStep,
    required this.titleController,
    required this.targetController,
    required this.remainingController,
  });

  final bool isEditing;
  final bool openedFromDraft;
  final List<TaskCategory> categories;
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
                for (final cat in widget.categories)
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