import 'package:flutter/material.dart';
import 'package:location_based_task_management_app/view_model/task_provider/task_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TaskViewModel())],
      child: MaterialApp(),
    );
  }
}
