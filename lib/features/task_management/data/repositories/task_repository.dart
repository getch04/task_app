import '../models/task_model.dart';

class TaskRepository {
  final List<TaskModel> _tasks = [];

  List<TaskModel> getTasks() => _tasks;

  void addTask(TaskModel task) {
    _tasks.add(task);
  }



  void updateTask(TaskModel task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }

  void deleteTask(String taskId) {}
}