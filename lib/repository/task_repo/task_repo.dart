import 'package:location_based_task_management_app/data/network/firestore_service.dart';
import 'package:location_based_task_management_app/model/task_model.dart';

abstract class TaskRepository{
  final FirestoreService service;
  TaskRepository(this.service);
  Stream<List<TaskModel>>taskForAgentToday(String agentId);
  Future<TaskModel?>getTaskById(id);
}