import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:location_based_task_management_app/repository/task_repo/task_repo.dart';
import 'package:location_based_task_management_app/repository/task_repo/task_repo_impl.dart';
import 'package:location_based_task_management_app/view_model/task_provider/task_view_model.dart';
import 'package:provider/provider.dart';

import 'config/routes/routes_manager.dart';
import 'config/routes/routes_name.dart';
import 'config/theme/app_theme_data.dart';
import 'data/network/firestore_service.dart';
import 'data/network/hive_service.dart';
import 'model/task_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>("tasksBox");

  // Initialize services and repository
  final firebaseService = FirebaseService();
  final hiveService = HiveService();
  final taskRepository = TaskRepoImpl(firebaseService, hiveService);
  runApp(MyApp(taskRepository: taskRepository,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.taskRepository});
  final TaskRepository taskRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TaskViewModel(taskRepository))],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light, // Setting theme mode to dark
        theme: AppThemeData.lightThemeData, // Setting light theme
        darkTheme: AppThemeData.darkThemeData, // Setting dark theme      title: 'task',

        initialRoute: RoutesName.home, // Initial route
        onGenerateRoute: Routes.generateRoute, // Generating routes
      ),
    );
  }
}
