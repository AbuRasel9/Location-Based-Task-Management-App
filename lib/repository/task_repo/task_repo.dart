import 'package:location_based_task_management_app/config/services/check_online_services.dart';
import 'package:location_based_task_management_app/data/network/firestore_service.dart';
import 'package:location_based_task_management_app/data/network/hive_service.dart';
import 'package:location_based_task_management_app/model/task_model.dart';

abstract class TaskRepository{
  final FirebaseService service;
  final HiveService hive;
  TaskRepository(this.service, this.hive);
  Future<List<TaskModel>>getTasks();
  Future<void>saveTask(TaskModel task);
  Future<void>updateTask(TaskModel task);
}