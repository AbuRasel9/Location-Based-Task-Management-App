import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/task_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream of tasks assigned to an agent for today
  Stream<List<TaskModel>> tasksForAgentToday(String agentId) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return _db
        .collection('tasks')
        .where('assignedTo', isEqualTo: agentId)
        .where('dueTime', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('dueTime', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .orderBy('dueTime')
        .snapshots()
        .map((snap) => snap.docs.map((d) => TaskModel.fromDocument(d)).toList());
  }

  // Optional: fetch single task_provider, or other operations
  Future<TaskModel?> getTaskById(String id) async {
    final doc = await _db.collection('tasks').doc(id).get();
    if (!doc.exists) return null;
    return TaskModel.fromDocument(doc);
  }
}
