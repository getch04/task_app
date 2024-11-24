import 'package:tasks_app/features/task_management/domain/entities/task.dart';


class TaskState {
  final List<Task> tasks;
  final bool isLoading;

  TaskState({
    required this.tasks,
    this.isLoading = false,
  });

  TaskState copyWith({
    List<Task>? tasks,
    bool? isLoading,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
