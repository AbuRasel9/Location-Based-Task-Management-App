import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime dueTime;

  @HiveField(3)
  double latitude;

  @HiveField(4)
  double longitude;

  @HiveField(5)
  bool completed;

  @HiveField(6)
  String? parentTaskId;

  TaskModel({
    required this.id,
    required this.title,
    required this.dueTime,
    required this.latitude,
    required this.longitude,
    this.completed = false,
    this.parentTaskId,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      dueTime: DateTime.parse(map['dueTime']),
      latitude: map['latitude'],
      longitude: map['longitude'],
      completed: map['completed'],
      parentTaskId: map['parentTaskId'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'dueTime': dueTime.toIso8601String(),
    'latitude': latitude,
    'longitude': longitude,
    'completed': completed,
    'parentTaskId': parentTaskId,
  };
}
