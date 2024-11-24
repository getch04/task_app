import 'package:flutter/material.dart';
import 'package:tasks_app/features/task_management/domain/models/task.dart';

class TaskListSection extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task, bool) onTaskStatusChanged;

  const TaskListSection({
    super.key,
    required this.tasks,
    required this.onTaskStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title ?? ''),
          leading: Checkbox(
            value: task.progress == 100,
            onChanged: (value) => onTaskStatusChanged(task, value ?? false),
          ),
        );
      },
    );
  }
} 