import 'package:location_based_task_management_app/config/services/network_services.dart';
import 'package:location_based_task_management_app/model/task_model.dart';
import 'package:location_based_task_management_app/repository/task_repo/task_repo.dart';

class TaskRepoImpl extends TaskRepository {
  TaskRepoImpl(super.service, super.hive);

  @override
  Future<List<TaskModel>> getTasks() async {
    bool online=await NetworkCheck.isOnline();
    if(online){
     final onlineTask= await service.fetchTasks();
      await hive.saveTask(onlineTask);
      return onlineTask;
    }else{
      return hive.getTasks();
    }
 
  }

  @override
  Future<void> saveTask(TaskModel task) async {
    bool online = await NetworkCheck.isOnline();
    if(online){
      await service.createTask(task);
    }
    await hive.updateTask(task);


  }

  @override
  Future<void> updateTask(TaskModel task) async {
    bool online = await NetworkCheck.isOnline();
    if(online){
      await service.updateTask(task);
    }
    await hive.updateTask(task);
  }



}