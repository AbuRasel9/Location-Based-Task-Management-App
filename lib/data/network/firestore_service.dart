import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/task_model.dart';

class FirebaseService {
  final tasks = FirebaseFirestore.instance.collection("tasks");

  Future<List<TaskModel>> fetchTasks() async {
    try {
      final snap = await tasks.get();
      return snap.docs.map((e) => TaskModel.fromMap(e.data())).toList();
    } catch (e) {
      throw Exception(firebaseErrorMessage(e));
    }
  }

  Future<void> createTask(TaskModel task) async {
    try {
      await tasks.doc(task.id).set(task.toMap());
    } catch (e) {
      throw Exception(firebaseErrorMessage(e));
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await tasks.doc(task.id).update(task.toMap());
    } catch (e) {
      throw Exception(firebaseErrorMessage(e));
    }
  }

  String firebaseErrorMessage(e) {
    switch (e.code) {
      case "permission-denied":
        return "You do not have permission to access this data.";
      case "unauthenticated":
        return "You must be logged in to perform this action.";
      case "not-found":
        return "The requested document was not found.";
      case "already-exists":
        return "This data already exists.";
      case "cancelled":
        return "The request was cancelled.";
      case "aborted":
        return "The operation was aborted due to a conflict.";
      case "deadline-exceeded":
        return "The request took too long.";
      case "resource-exhausted":
        return "Quota exceeded. Try again later.";
      case "failed-precondition":
        return "Operation failed due to precondition.";
      case "unavailable":
        return "Service unavailable. Check connection.";
      case "data-loss":
        return "Data loss detected.";
      case "internal":
        return "Internal server error.";
      case "invalid-argument":
        return "Invalid argument passed.";
      default:
        return "An unknown Firestore error occurred.";
    }
  }
}
