import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../model/task_model.dart';
import '../../view_model/task_provider/task_view_model.dart';
import '../../config/services/location_service.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskModel task;

  TaskDetailsScreen({required this.task});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  bool isLoading = false;
  Position? userPosition;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      setState(() {
        userPosition = position;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cannot get location: $e")),
      );
    }
  }

  Future<void> completeTask() async {
    final taskProvider = context.read<TaskViewModel>();
    setState(() {
      isLoading = true;
    });

    final msg = await taskProvider.completeTask(widget.task);

    if (msg != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskLatLng = LatLng(widget.task.latitude, widget.task.longitude);

    LatLng initialCenter = userPosition != null
        ? LatLng(userPosition!.latitude, userPosition!.longitude)
        : taskLatLng;

    return Scaffold(
      appBar: AppBar(title: Text(widget.task.title)),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: initialCenter,
                initialZoom: 15,
              ),
              children: [
                // Production-safe OpenStreetMap tile server
                TileLayer(
                  urlTemplate: "https://a.tile.openstreetmap.de/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.location_based_task_management_app',
                ),

                // Markers
                MarkerLayer(
                  markers: [
                    // Task location marker
                    Marker(
                      point: taskLatLng,
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.location_pin,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),

                    // User location marker
                    if (userPosition != null)
                      Marker(
                        point: LatLng(userPosition!.latitude, userPosition!.longitude),
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.my_location,
                          size: 35,
                          color: Colors.blue,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          ListTile(
            title: Text("Task Location"),
            subtitle: Text("${widget.task.latitude}, ${widget.task.longitude}"),
          ),

          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
            onPressed: () async {
              await completeTask();
            },
            child: Text("Complete Task"),
          ),
        ],
      ),
    );
  }
}
