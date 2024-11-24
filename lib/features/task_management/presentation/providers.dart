import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/task_repository.dart';
import '../domain/task_controller.dart';
import '../domain/task_state.dart';

final taskRepositoryProvider = Provider((ref) => TaskRepository());

final taskControllerProvider =
    StateNotifierProvider<TaskController, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskController(repository);
});
