import 'package:flutter/material.dart';
import 'package:location_based_task_management_app/utils/extensions/context_ext.dart';

import '../../../model/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme=context.theme;
    return ListTile(
      title: Text(task.title),
      subtitle: Text("Due: ${task.dueTime}"),
      trailing: Icon(task.completed?Icons.check_circle:Icons.pending,
        color: task.completed?theme.colorScheme.tertiary:theme.colorScheme.error
      ),
    );
  }
}
