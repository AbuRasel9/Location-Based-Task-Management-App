import 'package:flutter/material.dart';
import 'package:location_based_task_management_app/repository/task_repo/task_repo.dart';
import 'package:location_based_task_management_app/repository/task_repo/task_repo_impl.dart';
import 'package:location_based_task_management_app/view_model/task_provider/task_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp(,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.taskRepository});
  final TaskRepository taskRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TaskViewModel(taskRepository))],
      child: MaterialApp(),
    );
  }
}
