import 'package:flutter/material.dart';
import 'package:location_based_task_management_app/view/home/widget/task_item_widget.dart';
import 'package:location_based_task_management_app/view_model/task_provider/task_view_model.dart';
import 'package:provider/provider.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void getTask()async{
    final taskProvider=context.read<TaskViewModel>();
    taskProvider.setLoadin(true);
    await taskProvider.getTask();
    taskProvider.setLoadin(false);


  }
  @override
  void initState() {
    getTask();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final taskProvider=Provider.of<TaskViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Today Task"),
      ),
      body:taskProvider.loading?Center(
        child: CircularProgressIndicator(),
      ) :ListView.builder(
        itemCount: taskProvider.task.length,
        itemBuilder: (context, index) {
          final task=taskProvider.task[index];
          return TaskItemWidget(task: task);

      },),
    );
  }
}
