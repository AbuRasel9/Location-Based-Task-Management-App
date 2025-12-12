import 'package:location_based_task_management_app/model/task_model.dart';

class DependencyChecker{
  static bool canComplete(TaskModel task,List<TaskModel>all){
    if(task.parentTaskId==null){
      return true;
    }
    final parent = all.firstWhere((t) => t.id == task.parentTaskId);
    return parent.completed;

  }
}