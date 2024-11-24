import 'package:flutter/material.dart';
import 'package:tasks_app/core/constants/strings.dart';
import 'package:tasks_app/features/task_management/domain/entities/task.dart';

import 'task_section_widget.dart';

class TaskListWidget extends StatelessWidget {
  final List<Task> tasks;

  const TaskListWidget({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TaskSectionWidget(
          title: AppStrings.developmentTeam,
          tasks: tasks,
        ),
        const TaskSectionWidget(
          title: AppStrings.aigStudyTeam,
          tasks: [],
        ),
      ],
    );
  }
}
