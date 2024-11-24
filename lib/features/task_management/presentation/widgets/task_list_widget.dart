part of task_management_presentation_widgets;
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
