import 'package:flutter/material.dart';
import 'dart:math';
import 'package:tasks_app/core/theme/app_theme.dart';
import 'package:tasks_app/features/task_management/domain/models/task.dart';
import 'package:tasks_app/features/task_management/domain/services/assignee_color_service.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(bool) onStatusChanged;
  final _colorService = AssigneeColorService();

  TaskItem({
    super.key,
    required this.task,
    required this.onStatusChanged,
  });

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
                onChanged: (value) => onStatusChanged(value ?? false),
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
                              _colorService.getAssigneeColor(entry.value),
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
}
