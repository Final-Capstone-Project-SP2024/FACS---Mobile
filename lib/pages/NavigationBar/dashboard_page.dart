import 'package:facs_mobile/services/record_service.dart';
import 'package:facs_mobile/utils/dashboard_data.dart';
import 'package:facs_mobile/routeObserver.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with RouteAware{
  bool _showText = true;
  String detectionStatus = 'safe';
  RecordService _recordServices = RecordService();

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchDataAndUpdateStatus();
  // }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    _fetchDataAndUpdateStatus();
  }
  @override
  void didPopNext() {
    _fetchDataAndUpdateStatus();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  void _fetchDataAndUpdateStatus() async {
    try {
      List<Map<String, dynamic>> recentRecords = await DashboardData().fetchRecentRecords();
      if (recentRecords.isNotEmpty) {
        setState(() {
          detectionStatus = 'at_risk';
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  double _getSizedBoxHeight(int itemCount) {
      switch (itemCount) {
        case 1:
          return 300.0;
        case 2:
          return 240.0;
        case 3:
          return 155.0;
        case 4:
          return 75.0;
        case 5:
          return 0.0;
        default:
          return 435.0;
      }
    }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(detectionStatus);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
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
                      'Fire Detection Status:\n${detectionStatus.toUpperCase()}',
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
          ),
          Expanded(
            flex: 2,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: DashboardData().fetchRecentRecords(),
              builder: (context, recordsSnapshot) {
                if (recordsSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (recordsSnapshot.hasError) {
                  return Center(child: Text('Error fetching records: ${recordsSnapshot.error}'));
                } else {
                  List<Map<String, dynamic>> recentRecords = recordsSnapshot.data ?? [];
                  if (recentRecords.isNotEmpty && detectionStatus != 'at_risk') {
                    setState(() {
                      detectionStatus = 'at_risk';
                    });
                  }
                  return FutureBuilder<List<dynamic>>(
                    future: DashboardData().fetchDisconnectedCameras(),
                    builder: (context, camerasSnapshot) {
                      if (camerasSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (camerasSnapshot.hasError) {
                        return Center(child: Text('Error fetching cameras: ${camerasSnapshot.error}'));
                      } else {
                        List<dynamic> disconnectedCameras = camerasSnapshot.data ?? [];
                        return SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: Stack(
                              children: [
                                Container(
                                  color: statusColor,
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(45.0),
                                        topRight: Radius.circular(45.0),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(height: 30),
                                        _buildActiveIncidents(recentRecords),
                                        SizedBox(height: 30),
                                        _buildDisconnectedCamera("Disconnected Camera", disconnectedCameras),
                                        SizedBox(height: _getSizedBoxHeight(recentRecords.length)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveIncidents(List<Map<String, dynamic>> recentRecords) {
    if (recentRecords.isEmpty) {
      return Column(
        children: [
          Text(
            "Current Active Incidents",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            "No active incidents",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
        ],
      );
    }

    List<Widget> incidentWidgets = [
      Text(
        "Current Active Incidents",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 10.0),
    ];

    incidentWidgets.addAll(recentRecords.map((record) {
      return Column(
        children: [
          _buildSingleActiveIncident(record),
          SizedBox(height: 10.0),
        ],
      );
    }));
    if (recentRecords.length == 1) {
      incidentWidgets.insert(0, SizedBox(height: 20.0));
    }

    return Column(
      children: incidentWidgets,
    );
  }

Widget _buildSingleActiveIncident(Map<String, dynamic> record) {
  DateTime recordTime = DateTime.parse(record['recordTime']);
  String formattedDate = DateFormat.yMMMd().add_jm().format(recordTime);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date & Time: $formattedDate',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          'Status: ${record['status']}',
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}


  Widget _buildDisconnectedCamera(String title, List<dynamic> disconnectedCameras) {
    if (disconnectedCameras.isEmpty) {
      return Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            "No disconnected cameras",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
        ],
      );
    }

    List<Widget> cameraWidgets = [
      Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 10.0),
    ];

    cameraWidgets.addAll(disconnectedCameras.map((camera) {
      return Column(
        children: [
          _buildSingleDisconnectedCamera(camera),
          SizedBox(height: 10.0),
        ],
      );
    }));

    return Column(
      children: cameraWidgets,
    );
  }

  Widget _buildSingleDisconnectedCamera(Map<String, dynamic> camera) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Camera Name: ${camera['cameraName']}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'Status: ${camera['status']}',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            'Camera Destination: ${camera['cameraDestination']}',
            style: TextStyle(color: Colors.white),
          ),
        ],
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
}
