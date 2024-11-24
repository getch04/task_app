// lib/features/task_management/presentation/screens/task_list_screen.dart
import 'dart:math' show min, Random;

import 'package:flutter/material.dart';
import 'package:tasks_app/core/constants/strings.dart';
import 'package:tasks_app/core/theme/app_theme.dart';
import 'package:tasks_app/features/task_management/presentation/widgets/add_task_bottom_sheet.dart';

class Task {
  final String title;
  final DateTime dueDate;
  final List<String> assignees;
  double progress;

  Task({
    required this.title,
    required this.dueDate,
    required this.assignees,
    this.progress = 0,
  });
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> tasks = [
    Task(
      title: 'Survey review and analysis',
      dueDate: DateTime(2024, 10, 12, 13), // 1:00 PM
      assignees: ['M', 'T', 'GM', 'F'],
      progress: 3,
    ),
    Task(
      title: 'Calendar integration',
      dueDate: DateTime(2024, 10, 12, 17), // 5:00 PM
      assignees: ['M', 'B'],
      progress: 5,
    ),
    Task(
      title: 'Cloud-based backend for task data and messages',
      dueDate: DateTime(2024, 10, 12, 17), // 5:00 PM
      assignees: ['MG'],
      progress: 0,
    ),
  ];

  final Map<String, bool> _expandedSections = {};
  final Map<String, Color> _assigneeColors = {};

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
              child: _buildTaskList(),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.notifications_outlined,
                    size: 32,
                  ),
                )),
            onPressed: () {},
          ),
          const Text(
            AppStrings.appTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.archive_outlined,
                    size: 32,
                  )),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: SizedBox(
        height: 55,
        child: TextField(
          decoration: InputDecoration(
            hintText: AppStrings.search,
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            suffixIcon: Icon(
              Icons.search,
              size: 30,
              color: Colors.grey.shade600,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickFilters() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterButton(AppStrings.today, Icons.calendar_today),
          const SizedBox(
            width: 10,
          ),
          _buildFilterButton(AppStrings.scheduled, Icons.schedule),
          const SizedBox(
            width: 10,
          ),
          _buildFilterButton(AppStrings.assignedToMe, Icons.person_outline),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: AppTheme.iconBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.textSecondary),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView(
      children: [
        _buildTeamSection(AppStrings.developmentTeam, tasks),
        _buildTeamSection(AppStrings.aigStudyTeam, []),
      ],
    );
  }

  Widget _buildTeamSection(String title, List<Task> tasks) {
    _expandedSections.putIfAbsent(title, () => true);
    final isExpanded = _expandedSections[title]!;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            color: isExpanded ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: isExpanded ? Border.all(color: Colors.grey[300]!) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _expandedSections[title] = !isExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              size: 38,
                              color:
                                  isExpanded ? Colors.grey[500] : Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _expandedSections[title] = !isExpanded;
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: isExpanded
                                  ? const Color(0xFF4525A2)
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          size: 34,
                          color: isExpanded ? Colors.grey[500] : Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded) ...[
                ...tasks.map((task) => Column(
                      children: [
                        _buildTaskItem(task),
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
          ),
        ),
        if (!isExpanded)
          Divider(
            color: Colors.grey[300],
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }

  Widget _buildTaskItem(Task task) {
    return

    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: task.progress == 100,
                            onChanged: (bool? value) {
                              setState(() {
                                task.progress = value! ? 100 : 0;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Expanded(
                            child: Text(
                              task.title,
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 50),
                    Text(
                      '${task.progress.toInt()}%',
                      style: TextStyle(
                        fontSize: 16,
                        color: task.progress != 0
                            ? AppTheme.textSecondary
                            : AppTheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: task.progress != 0
                            ? AppTheme.warning.withOpacity(0.2)
                            : AppTheme.error.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Oct 12  ${task.dueDate.hour}:${task.dueDate.minute.toString().padLeft(2, '0')} PM',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 24.0 * min(task.assignees.length, 2) +
                          (task.assignees.length > 2 ? 24 : 0),
                      height: 24.0,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ...task.assignees
                              .take(2)
                              .toList()
                              .asMap()
                              .entries
                              .map((entry) => Positioned(
                                    left: entry.key * 16.0,
                                    child: _buildAssigneeChip(
                                      entry.value,
                                      backgroundColor:
                                          _getAssigneeColor(entry.value),
                                    ),
                                  )),
                          if (task.assignees.length > 2)
                            Positioned(
                              left: 2 * 16.0,
                              child: _buildAssigneeChip(
                                '+${task.assignees.length - 2}',
                                backgroundColor: Colors.yellow[800],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.more_horiz),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );


  }

  Widget _buildAssigneeChip(String initials, {Color? backgroundColor}) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAddTaskButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: OutlinedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => const AddTaskBottomSheet(),
          );
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Text(
              AppStrings.addTask,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        selectedLabelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: AppStrings.tasks,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: AppStrings.communication,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: AppStrings.profile,
          ),
        ],
      ),
    );
  }

  Color _getAssigneeColor(String assignee) {
    return _assigneeColors.putIfAbsent(assignee, () {
      final colors = [
        Colors.blue[400]!,
        Colors.purple[400]!,
        Colors.green[400]!,
        Colors.orange[400]!,
        Colors.pink[400]!,
        Colors.teal[400]!,
      ];
      return colors[Random().nextInt(colors.length)];
    });
  }



}
