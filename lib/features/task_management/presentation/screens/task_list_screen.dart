import 'package:flutter/material.dart';
import 'package:tasks_app/core/constants/strings.dart';
import 'package:tasks_app/features/task_management/domain/models/task.dart';
import 'package:tasks_app/features/task_management/presentation/widgets/task_header.dart';
import 'package:tasks_app/features/task_management/presentation/widgets/task_search_bar.dart';
import 'package:tasks_app/features/task_management/presentation/widgets/task_quick_filters.dart';
import 'package:tasks_app/features/task_management/presentation/widgets/task_bottom_navigation.dart';
import 'package:tasks_app/features/task_management/presentation/widgets/task_item.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> tasks = [/* ... existing tasks ... */];
  final Map<String, bool> _expandedSections = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildQuickFilters(),
            Expanded(
              child: ListView(
                children: [
                  _buildTeamSection(AppStrings.developmentTeam, tasks),
                  _buildTeamSection(AppStrings.aigStudyTeam, []),
                ],
              ),
            ),
            _buildAddTaskButton(),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const TaskHeader();
  }

  Widget _buildSearchBar() {
    return const TaskSearchBar();
  }

  Widget _buildQuickFilters() {
    return const TaskQuickFilters();
  }

  Widget _buildTeamSection(String title, List<Task> tasks) {
    _expandedSections.putIfAbsent(title, () => true);
    final isExpanded = _expandedSections[title]!;

    return Column(
      children: [
        // ... existing section header ...
        if (isExpanded) ...[
          ...tasks.map((task) => Column(
                children: [
                  TaskItem(
                    task: task,
                    onStatusChanged: (completed) {
                      setState(() {
                        task.progress = completed ? 100 : 0;
                      });
                    },
                  ),
                  if (task != tasks.last)
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              )),
          _buildAddTaskButton(),
        ],
      ],
    );
  }

  Widget _buildAddTaskButton() {
    return TextButton(
      onPressed: () {
        // TODO: Implement add task functionality
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add),
          SizedBox(width: 8),
          Text('Add Task'),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return const TaskBottomNavigation();
  }

  void _handleTaskStatusChange(Task task, bool completed) {
    setState(() {
      task.progress = completed ? 100 : 0;
    });
  }
}