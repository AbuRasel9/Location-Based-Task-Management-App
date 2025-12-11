import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String? description;
  final DateTime? dueTime;
  final String status;
  final double? lat;
  final double? lng;
  final String? parentTaskId;
  final String? assignedTo;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.dueTime,
    required this.status,
    this.lat,
    this.lng,
    this.parentTaskId,
    this.assignedTo,
  });

  factory TaskModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final location = data['location'] as Map<String, dynamic>?;
    Timestamp? dueTs = data['dueTime'] as Timestamp?;
    return TaskModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'],
      dueTime: dueTs?.toDate(),
      status: data['status'] ?? 'pending',
      lat: location != null ? (location['lat']?.toDouble()) : null,
      lng: location != null ? (location['lng']?.toDouble()) : null,
      parentTaskId: data['parentTaskId'],
      assignedTo: data['assignedTo'],
    );
  }
}
