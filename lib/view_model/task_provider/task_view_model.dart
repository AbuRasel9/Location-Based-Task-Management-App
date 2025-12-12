import 'dart:developer';

import 'package:flutter/cupertino.dart';
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

  Future<void> getTask() async {
    _task = await repo.getTasks();
    notifyListeners();
  }

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

}
