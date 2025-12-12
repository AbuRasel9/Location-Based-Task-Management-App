import 'package:flutter/material.dart';
import 'package:location_based_task_management_app/utils/extensions/context_ext.dart';
import 'package:provider/provider.dart';

import '../../model/task_model.dart';
import '../../view_model/task_provider/task_view_model.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskModel task;

  TaskDetailsScreen({required this.task});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  bool isLoading = false;

  Future<void> completeTask() async {
    final taskProvider = context.read<TaskViewModel>();
    setState(() {
      isLoading = true;
    });

    final msg = await taskProvider.completeTask(widget.task);
    if (msg != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskViewModel>(context);
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(title: Text(widget.task.title)),
      body: Column(
        children: [
          Container(
            height: 200,
            color: theme.colorScheme.primary,
            child: Center(child: Text("Map Preview")),
          ),
          ListTile(
            title: Text("Task Location"),
            subtitle: Text("${widget.task.latitude}, ${widget.task.longitude}"),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    completeTask();
                  },
                  child: Text("Complete Task"),
                ),
        ],
      ),
    );
  }
}
