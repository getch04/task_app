// lib/features/task_management/presentation/screens/task_list_screen.dart
import 'package:flutter/material.dart';
import 'package:tasks_app/features/task_management/domain/entities/task.dart';
import 'package:tasks_app/features/task_management/presentation/widgets/task_bottom_navigation.dart';

import '../widgets/header_widget.dart';
import '../widgets/quick_filters_widget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/task_list_widget.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> tasks = [
    Task(
      id: '1',
      createdAt: DateTime.now(),
      title: 'Survey review and analysis',
      dueDate: DateTime(2024, 10, 12, 13),
      assignees: ['M', 'T', 'GM', 'F'],
      progress: 3,
    ),
    Task(
      id: '2',
      createdAt: DateTime.now(),
      title: 'Calendar integration',
      dueDate: DateTime(2024, 10, 12, 13),
      assignees: [
        'M',
        'T',
      ],
      progress: 3,
    ),
    //Cloud-based backend for task data and messages
    Task(
      id: '3',
      createdAt: DateTime.now(),
      title: 'Cloud-based backend for task data and messages',
      dueDate: DateTime(2024, 10, 12, 13),
      assignees: [
        'M',
      ],
      progress: 0,
    ),
    // ... other tasks
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const HeaderWidget(),
            const SearchBarWidget(),
            const QuickFiltersWidget(),
            Expanded(
              child: TaskListWidget(tasks: tasks),
            ),
            const TaskBottomNavigation(),
          ],
        ),
      ),
    );
  }
}
