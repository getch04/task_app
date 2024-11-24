import 'package:flutter/material.dart';
import 'package:tasks_app/features/task_management/domain/entities/task.dart';
import 'dart:math' show min;
import 'assignee_chip_widget.dart';
import 'package:tasks_app/core/theme/app_theme.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTaskHeader(context),
                _buildTaskFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Checkbox(
                value: task.progress == 100,
                onChanged: (bool? value) {
                  // Handle checkbox change
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
            color: task.progress != 0 ? AppTheme.textSecondary : AppTheme.error,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 20),
        _buildDueDate(),
        const SizedBox(width: 10),
        _buildAssignees(),
        const Spacer(),
        _buildMoreButton(),
      ],
    );
  }

  Widget _buildDueDate() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            'Oct 12  ${task.dueDate?.hour}:${task.dueDate?.minute.toString().padLeft(2, '0')} PM',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignees() {
    return SizedBox(
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
                    child: AssigneeChipWidget(
                      initials: entry.value,
                    ),
                  )),
          if (task.assignees.length > 2)
            Positioned(
              left: 2 * 16.0,
              child: AssigneeChipWidget(
                initials: '+${task.assignees.length - 2}',
                backgroundColor: Colors.yellow[800],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMoreButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Padding(
        padding: EdgeInsets.all(5.0),
        child: Icon(Icons.more_horiz),
      ),
    );
  }
}