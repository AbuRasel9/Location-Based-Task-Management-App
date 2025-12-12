import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:location_based_task_management_app/repository/task_repo/task_repo.dart';

import '../../model/task_model.dart';

class TaskViewModel with ChangeNotifier{
  final TaskRepository repository;
  TaskViewModel({required this.repository});
  //variable
  Stream<List<TaskModel>>? _agentTaskList;
  TaskViewModel? _taskById;
  bool _isLoading=false;

  //get list
  Stream<List<TaskModel>>?get agentTaskList=>_agentTaskList;
  TaskViewModel? get taskById=>_taskById;
  bool get isLoading=>_isLoading;

  //method
  void setLoading({required bool loadingValue}){
    _isLoading=loadingValue;
    notifyListeners();
  }

  Future<void> todayTaskList({ required String agentId})async{
    try{
      _agentTaskList=repository.taskForAgentToday(agentId);
      notifyListeners();
    }catch(e){
      log("error $e");
      throw Exception(e);
    }





  }
  Future<void>taskListById({required String id}) async {
    _taskById=await repository.getTaskById(id);

  }







}