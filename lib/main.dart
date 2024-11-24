import 'package:flutter/material.dart';
import 'package:tasks_app/core/theme/app_theme.dart';
import 'package:tasks_app/features/task_management/presentation/screens/task_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: AppTheme.light,
      home: const TaskListScreen(),
    );
  }
}
