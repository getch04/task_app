// lib/features/task_management/presentation/screens/task_list_screen.dart
import 'package:flutter/material.dart';
import 'package:tasks_app/features/task_management/domain/entities/task.dart';
import 'package:tasks_app/features/task_management/presentation/widgets/widgets.dart';

/// A screen widget that displays a list of tasks with filtering and navigation capabilities.
///
/// This screen includes:
/// - A header section
/// - Search functionality
/// - Quick filters for task categorization
/// - Scrollable list of tasks
/// - Bottom navigation
class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Sample task data - TODO: Replace with data from a repository
  final List<Task> tasks = [
    Task(
      id: '1',
      createdAt: DateTime.now(),
      title: 'Survey review and analysis',
      dueDate: DateTime(2024, 10, 12, 13),
      assignees: ['M', 'T', 'GM', 'F'],  // TODO: Use proper user identifiers
      progress: 3,
    ),
    // Task for calendar integration feature
    Task(
      id: '2',
      createdAt: DateTime.now(),
      title: 'Calendar integration',
      dueDate: DateTime(2024, 10, 12, 13),
      assignees: ['M', 'T'],
      progress: 3,
    ),
    // Task for backend implementation
    Task(
      id: '3',
      createdAt: DateTime.now(),
      title: 'Cloud-based backend for task data and messages',
      dueDate: DateTime(2024, 10, 12, 13),
      assignees: ['M'],
      progress: 0,
    ),
    // ... other tasks
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,  // Allow content to extend behind bottom navigation
        child: Column(
          children: [
            const HeaderWidget(),        // Displays screen header
            const SearchBarWidget(),     // Provides task search functionality
            const QuickFiltersWidget(),  // Shows task filtering options
            Expanded(
              child: TaskListWidget(tasks: tasks),  // Scrollable list of tasks
            ),
            const TaskBottomNavigation(),  // Bottom navigation bar
          ],
        ),
      ),
    );
  }
}
