import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/task_model.dart';

class FirebaseService {
  final tasks = FirebaseFirestore.instance.collection("tasks");

  /// FETCH TASKS
  Future<Map<String, dynamic>> fetchTasks() async {
    try {
      final snap = await tasks.get();
      final list = snap.docs.map((e) {
        final data = e.data();
        data["id"] = e.id;
        return TaskModel.fromMap(data);
      }).toList();

      return {"status": 200, "data": list};
    } on FirebaseException catch (e) {
      return {"status": 400, "error": firebaseErrorMessage(e)};
    } catch (e, stack) {
      log("Fetch error: $e\n$stack");
      return {"status": 500, "error": e.toString()};
    }
  }

  /// CREATE TASK
  Future<Map<String, dynamic>> createTask(TaskModel task) async {
    try {
      await tasks.doc(task.id).set(task.toMap());
      return {"status": 200, "message": "Task created successfully"};
    } on FirebaseException catch (e) {
      return {"status": 400, "error": firebaseErrorMessage(e)};
    } catch (e, stack) {
      log("Create error: $e\n$stack");
      return {"status": 500, "error": e.toString()};
    }
  }

  /// UPDATE TASK
  Future<Map<String, dynamic>> updateTask(TaskModel task) async {
    try {
      await tasks.doc(task.id).update(task.toMap());
      return {"status": 200, "message": "Task updated successfully"};
    } on FirebaseException catch (e) {
      return {"status": 400, "error": firebaseErrorMessage(e)};
    } catch (e, stack) {
      log("Update error: $e\n$stack");
      return {"status": 500, "error": e.toString()};
    }
  }

  /// ERROR MESSAGES
  String firebaseErrorMessage(FirebaseException e) {
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
