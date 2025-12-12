
import '../../data/network/firestore_service.dart';
import '../../data/network/hive_service.dart';
import '../../model/task_model.dart';

abstract class TaskRepository{
  final FirebaseService service;
  final HiveService hive;
  TaskRepository(this.service, this.hive);
  Future<List<TaskModel>>getTasks();
  Future<void>saveTask(TaskModel task);
  Future<void>updateTask(TaskModel task);
}