import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:location_based_task_management_app/config/services/dependency_checker.dart';
import 'package:location_based_task_management_app/config/services/location_service.dart';
import 'package:location_based_task_management_app/repository/task_repo/task_repo.dart';

import '../../model/task_model.dart';

class TaskViewModel with ChangeNotifier {
  final TaskRepository repo;

  TaskViewModel(this.repo);

  //variable
  List<TaskModel> _task = [];
  bool _loading = false;

  //get variable
  List<TaskModel> get task => _task;

  bool get loading => _loading;
  //method

  //get all task

  Future<void> getTask() async {
    _task = await repo.getTasks();
    notifyListeners();
  }
//check in for complete task
  Future<String?> checkIn(TaskModel task) async {
    final position = await LocationService.getCurrentLocation();
    final distance = LocationService.distanceBetween(
      position.latitude,
      position.longitude,
      task.latitude,
      task.longitude,
    );
    if(distance>100){
      return "You must be within 100 meters to check-in.";
    }
    return null;
  }
  Future<String?>completeTask(TaskModel task)async{

    //check dependency for parent task
    if(!DependencyChecker.canComplete(task, _task)){
      return "You must complete parent task first!";
    }
    final checkMsg=await checkIn(task);
    //check in for complete task
    if(checkMsg!=null){
      return  checkMsg;
    }
    task.completed=true;
    await repo.updateTask(task);
    await getTask();
    return null;
  }

}
