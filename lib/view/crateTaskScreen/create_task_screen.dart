import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/task_model.dart';
import '../../model/task_model.dart';
import '../../view_model/task_provider/task_view_model.dart';
import '../../viewmodels/task_viewmodel.dart';
import 'package:uuid/uuid.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final titleCtrl = TextEditingController();
  double? lat;
  double? lon;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Create Task")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(controller: titleCtrl, decoration: InputDecoration(labelText: "Title")),
            ElevatedButton(
              child: Text("Pick Location"),
              onPressed: () async {
                lat = 23.78;
                lon = 90.41;
                setState(() {});
              },
            ),
            Text("Lat: $lat, Lon: $lon"),
            ElevatedButton(
              child: Text("Save Task"),
              onPressed: () async {
                final task = TaskModel(
                  id: Uuid().v4(),
                  title: titleCtrl.text,
                  dueTime: DateTime.now(),
                  latitude: lat!,
                  longitude: lon!,
                );

                await taskProvider.createTask(task);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
