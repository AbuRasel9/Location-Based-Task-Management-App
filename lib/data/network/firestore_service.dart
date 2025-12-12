import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/task_model.dart';

class FirebaseService {
  final tasks = FirebaseFirestore.instance.collection("tasks");

  Future<List<TaskModel>> fetchTasks() async {
    final snap = await tasks.get();
    return snap.docs.map((e) => TaskModel.fromMap(e.data())).toList();
  }

  Future<void> createTask(TaskModel task) async {
    await tasks.doc(task.id).set(task.toMap());
  }

  Future<void> updateTask(TaskModel task) async {
    await tasks.doc(task.id).update(task.toMap());
  }
}
