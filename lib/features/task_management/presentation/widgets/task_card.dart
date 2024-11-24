import 'package:flutter/material.dart';
import 'package:tasks_app/core/theme/app_theme.dart';
import 'package:tasks_app/features/task_management/domain/entities/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onMorePressed;
  final ValueChanged<bool?>? onCheckboxChanged;

  const TaskCard({
    super.key,
    required this.task,
    this.onMorePressed,
    this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: task.progress == 100,
              onChanged: onCheckboxChanged,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildDueTime(),
                    const SizedBox(width: 8),
                    _buildAssignees(),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: AppTheme.textSecondary),
            onPressed: onMorePressed,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildDueTime() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: task.progress == 0
            ? AppTheme.error.withOpacity(0.1)
            : AppTheme.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time,
            size: 14,
            color: task.progress == 0 ? AppTheme.error : AppTheme.warning,
          ),
          const SizedBox(width: 4),
          Text(
            '${task.dueDate!.hour}:${task.dueDate!.minute.toString().padLeft(2, '0')} PM',
            style: TextStyle(
              fontSize: 12,
              color: task.progress == 0 ? AppTheme.error : AppTheme.warning,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignees() {
    return Row(
      children: [
        for (int i = 0; i < task.assignees.length; i++)
          Transform.translate(
            offset: Offset(i * -8.0, 0), // Overlap effect
            child: _buildAssigneeChip(task.assignees[i]),
          ),
        if (task.assignees.length > 2)
          Transform.translate(
            offset: Offset((task.assignees.length - 1) * -8.0, 0),
            child: _buildMoreAssigneesChip(task.assignees.length - 2),
          ),
      ],
    );
  }

  Widget _buildAssigneeChip(String initials) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: AppTheme.primary,
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.surface, width: 1.5),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildMoreAssigneesChip(int count) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.amber,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Center(
        child: Text(
          '+$count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
