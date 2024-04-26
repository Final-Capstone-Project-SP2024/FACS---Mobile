import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/fix_camera_page.dart';
import 'package:facs_mobile/routeObserver.dart';
import 'package:facs_mobile/services/camera_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:facs_mobile/services/notification_services.dart';

EventBus eventBus = EventBus();

class RefreshDataEvent {}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with RouteAware {
  late StreamSubscription streamSubscription;
  String detectionStatus = 'safe';
  List<dynamic> notifications = [];
  List<dynamic> cameras = [];

  @override
  void initState() {
    super.initState();
    _fetchDataAndUpdateStatus();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      routeObserver.subscribe(
          this, ModalRoute.of(context)! as PageRoute<dynamic>);
    });
    streamSubscription = eventBus.on<RefreshDataEvent>().listen((event) {
      _fetchDataAndUpdateStatus();
    });
  }

  @override
  void didPopNext() {
    _fetchDataAndUpdateStatus();
    streamSubscription = eventBus.on<RefreshDataEvent>().listen((event) {
      _fetchDataAndUpdateStatus();
    });
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    streamSubscription.cancel();
    super.dispose();
  }

  Future<void> _fetchDataAndUpdateStatus() async {
    try {
      dynamic notificationData = await NotificationService.getNotification();
      dynamic cameraData = await CameraServices.getCamera();
      //Processing notification data (sorting date and time)
      if (notificationData != null &&
          notificationData is Map<String, dynamic>) {
        List<dynamic> fetchedNotifications = notificationData['data'];
        fetchedNotifications.sort((a, b) {
          try {
            DateTime dateA =
                DateFormat('HH:mm:ss dd-MM-yyyy').parse(a['occurrenceTime']);
            DateTime dateB =
                DateFormat('HH:mm:ss dd-MM-yyyy').parse(b['occurrenceTime']);
            return dateB.compareTo(dateA);
          } catch (e) {
            print('Error parsing date: ${a['occurrenceTime']}');
            return 0;
          }
        });
        setState(() {
          notifications = fetchedNotifications ?? [];
          if (notifications.isNotEmpty) {
            detectionStatus = 'at_risk';
          }
        });
      }
      //Processing camera data (take only status == disconnected)
      if (cameraData != null && cameraData is Map<String, dynamic>) {
        List<dynamic> allCameras = cameraData['data'];
        List<dynamic> disconnectedCameras = allCameras
            .where((camera) => camera['status'] == 'Disconnected')
            .toList();
        setState(() {
          cameras = disconnectedCameras ?? [];
          if (cameras.isNotEmpty && detectionStatus != 'at_risk') {
            detectionStatus = 'protential';
          }
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(detectionStatus);

    return Scaffold(
      backgroundColor: statusColor,
      body: RefreshIndicator(
        onRefresh: _fetchDataAndUpdateStatus,
        child: Column(
          children: [
            // Top section: Icon and Fire Detection Status
            Container(
              height: 150,
              color: statusColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getIconData(detectionStatus),
                      size: 50.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '${getStatusText(detectionStatus)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom section: Notifications and Disconnected Camera
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        _buildNotifications(),
                        SizedBox(height: 30),
                        _buildDisconnectedCameras(),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifications() {
    return Column(
      children: [
        Text(
          "Current active incident",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        if (notifications.isEmpty)
          Container(
            child: Column(
              children: [
                SizedBox(height: 10, width: MediaQuery.of(context).size.width),
                Text(
                  "No active incident",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 10, width: MediaQuery.of(context).size.width),
              ],
            ),
          )
        else
          Column(
            children: notifications.map((notification) {
              return _buildSingleNotification(notification);
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildSingleNotification(Map<String, dynamic> notification) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.report, color: Colors.red, size: 40),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location: ${notification['locationName']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    'Camera Destination: ${notification['cameraDestination']}'),
                Text('Occurrence Time: ${notification['occurrenceTime']}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisconnectedCameras() {
    return Column(
      children: [
        Text(
          "Disconnected Cameras",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        if (cameras.isEmpty)
          Container(
            child: Column(
              children: [
                SizedBox(height: 10, width: MediaQuery.of(context).size.width),
                Text(
                  "No disconnected cameras",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 10, width: MediaQuery.of(context).size.width),
              ],
            ),
          )
        else
          Column(
            children: cameras.map((camera) {
              return _buildSingleDisconnectedCamera(camera);
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildSingleDisconnectedCamera(Map<String, dynamic> camera) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FixCameraPage(
              cameraId: camera['cameraId'],
              cameraStatus: camera['status'],
              cameraDestination: camera['cameraDestination'],
              cameraName: camera['cameraName'],
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.videocam_off, color: Colors.red, size: 40),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Camera Name: ${camera['cameraName']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Monitoring: ${camera['cameraDestination']}'),
                  Text('Status: ${camera['status']}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'safe':
        return Color.fromARGB(255, 51, 160, 104);
      case 'potential':
        return Color.fromARGB(255, 255, 215, 0);
      case 'at_risk':
        return Color.fromARGB(255, 238, 75, 43);
      default:
        return Colors.grey;
    }
  }

  IconData _getIconData(String status) {
    switch (status) {
      case 'safe':
        return Icons.verified_user;
      case 'potential':
        return Icons.gpp_maybe;
      case 'at_risk':
        return Icons.gpp_bad;
      default:
        return Icons.error;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'safe':
        return 'No issue found';
      case 'potential':
        return 'Potential issue';
      case 'at_risk':
        return 'Immediate action required!';
      default:
        return 'Unknown status';
    }
  }
}
