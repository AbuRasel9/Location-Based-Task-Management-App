import 'package:hive/hive.dart';
import 'package:location_based_task_management_app/model/task_model.dart';

class HiveService {
  static const boxName = "tasksBox";
  Box<TaskModel> get box => Hive.box<TaskModel>(boxName);

  Future<void> saveTask(List<TaskModel> tasks) async {
    final box = Hive.box<TaskModel>(boxName);
    await box.clear();
    for (var t in tasks) {
      await box.put(t.id, t);
    }
  }

  List<TaskModel> getTasks() {
    final box = Hive.box<TaskModel>(boxName);
    return box.values.toList();
  }

  Future<void> updateTask(TaskModel task) async {
    final box = Hive.box<TaskModel>(boxName);
    await box.put(task.id, task);
  }
}
