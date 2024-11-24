import 'package:flutter/material.dart';

import '../../domain/entities/task.dart';
import 'task_card.dart';

class TaskSection extends StatelessWidget {
  final String title;
  final List<Task> tasks;
  final VoidCallback onAddTask;

  const TaskSection({
    super.key,
    required this.title,
    required this.tasks,
    required this.onAddTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          ...tasks.map((task) => TaskCard(task: task)),
          _buildAddTaskButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.expand_less, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAddTaskButton() {
    return InkWell(
      onTap: onAddTask,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.indigo[700]),
            const SizedBox(width: 8),
            Text(
              'Add Task',
              style: TextStyle(
                color: Colors.indigo[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
