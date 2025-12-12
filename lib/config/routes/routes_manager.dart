import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location_based_task_management_app/config/routes/routes_name.dart';
import 'package:location_based_task_management_app/view/crateTaskScreen/create_task_screen.dart';
import 'package:location_based_task_management_app/view/home/home_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomeView(),);
      case RoutesName.createTask:
        return MaterialPageRoute(builder: (context) => CreateTaskScreen(),);
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text("No route found"),
            ),
          );

        },);
    }
  }
}