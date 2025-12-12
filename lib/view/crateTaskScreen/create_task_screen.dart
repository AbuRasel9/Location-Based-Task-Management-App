import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location_based_task_management_app/utils/extensions/context_ext.dart';
import 'package:location_based_task_management_app/utils/extensions/date_time_ext.dart';
import 'package:provider/provider.dart';
import '../../model/task_model.dart';
import '../../view_model/task_provider/task_view_model.dart';
import 'package:uuid/uuid.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final titleCtrl = TextEditingController();
  final dateController = TextEditingController();
  double? lat;
  double? lon;
  DateTime? selectedDateTime;
  bool loading = false;

  Future<void> _pickDateTime() async {
    DateTime now = DateTime.now();
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _pickLocation() async {
    // For demo, we assign static values
    setState(() {
      lat = 23.78;
      lon = 90.41;
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskViewModel>(context);
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(title: Text("Create Task")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "Enter Title";
                  }
                  return null;
                },
                controller: titleCtrl,
                decoration: InputDecoration(
                  labelText: "Task Title",
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              SizedBox(height: 16),

              OutlinedButton.icon(
                icon: Icon(Icons.calendar_today),
                label: Text(
                  selectedDateTime == null
                      ? "Pick Due Date & Time"
                      : "${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year} ${selectedDateTime!.hour}:${selectedDateTime!.minute.toString().padLeft(2, '0')}",
                ),
                onPressed: _pickDateTime,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 16),
              OutlinedButton.icon(
                icon: Icon(Icons.location_on),
                label: Text(
                  lat != null && lon != null
                      ? "Location: $lat, $lon"
                      : "Pick Location",
                ),
                onPressed: _pickLocation,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 16),
              loading
                  ? Center(
                child: CircularProgressIndicator(
                ),
              )
                  : ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text("Save Task"),
                onPressed: () async {
                  if (titleCtrl.text.isEmpty ||
                      lat == null ||
                      lon == null ||
                      selectedDateTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please fill all fields and pick date & location",
                        ),
                      ),
                    );
                    return;
                  }

                  try {
                    loading = true;
                    setState(() {});
                    final task = TaskModel(
                      id: Uuid().v4(),
                      title: titleCtrl.text,
                      dueTime: selectedDateTime!,
                      latitude: lat!,
                      longitude: lon!,
                    );

                    await taskProvider.createTask(task);
                    loading = false;
                    setState(() {});
                  } catch (e) {
                    print("----------${e.toString()}");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );                                loading = false;
                    setState(() {});
                  }

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
