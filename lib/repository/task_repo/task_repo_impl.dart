import 'package:location_based_task_management_app/model/task_model.dart';
import 'package:location_based_task_management_app/repository/task_repo/task_repo.dart';

class TaskRepoImpl extends TaskRepository {
  TaskRepoImpl(super.service);

  @override
  Future<TaskModel?>getTaskById(id) {
    return service.getTaskById(id);

  }


  @override
  Stream<List<TaskModel>> taskForAgentToday(String agentId) {
    return  service.tasksForAgentToday(agentId);
  }


}