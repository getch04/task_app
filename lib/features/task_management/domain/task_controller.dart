import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/features/task_management/data/models/task_model.dart';
import '../data/repositories/task_repository.dart';
import 'task_state.dart';
import 'package:uuid/uuid.dart';

class TaskController extends StateNotifier<TaskState> {
  final TaskRepository _repository;
  final _uuid = const Uuid();

  TaskController(this._repository) : super(TaskState(tasks: []));

  void addTask(String title, String? description) {
    state = state.copyWith(isLoading: true);

    final task = TaskModel(
      id: _uuid.v4(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );

    _repository.addTask(task);
    state = state.copyWith(
      tasks: _repository.getTasks(),
      isLoading: false,
    );
  }

  void toggleTaskCompletion(String taskId) {
    final tasks = state.tasks;
    final taskIndex = tasks.indexWhere((task) => task.id == taskId);

    if (taskIndex != -1) {
      final task = tasks[taskIndex];
      final updatedTask = TaskModel.fromTask(
        task.copyWith(isCompleted: !task.isCompleted)
      );
      _repository.updateTask(updatedTask);

      state = state.copyWith(tasks: _repository.getTasks());
    }
  }

  void deleteTask(String taskId) {
    _repository.deleteTask(taskId);
  }
}