import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required String id,
    required String title,
    String? description,
    DateTime? dueDate,
    List<String> assignees = const [],
    double progress = 0,
    bool isCompleted = false,
    DateTime? createdAt,
  }) : super(
         id: id,
         title: title,
         description: description,
         createdAt: createdAt ?? DateTime.now(),
         dueDate: dueDate,
         assignees: assignees,
         progress: progress,
         isCompleted: isCompleted,
       );

  factory TaskModel.fromTask(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      createdAt: task.createdAt,
      dueDate: task.dueDate,
      assignees: task.assignees,
      progress: task.progress,
      isCompleted: task.isCompleted,
    );
  }
}