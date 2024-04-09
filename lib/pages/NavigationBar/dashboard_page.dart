import 'package:flutter/material.dart';
import 'package:facs_mobile/services/record_service.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/action/action_page.dart';
import 'package:facs_mobile/services/camera_services.dart'; // Import camera services

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final RecordService _recordServices = RecordService();
  List<Map<String, dynamic>> _records = [];
  List<dynamic> cameraData = [];
  String detectionStatus = 'safe';

  @override
  void initState() {
    super.initState();
    _fetchRecords();
    _fetchCameraData();
  }

  Future<void> _fetchRecords() async {
  try {
    List<Map<String, dynamic>> records = await _recordServices.getRecords();

    // Sort the records in ascending order based on recordTime
    records.sort((a, b) => DateTime.parse(a['recordTime']).compareTo(DateTime.parse(b['recordTime'])));

    // Check for incidents
    bool hasIncident = records.any((record) => record['status'] == 'InAlarm' || record['status'] == 'InVote');

    setState(() {
      _records = records;
      detectionStatus = hasIncident ? 'at_risk' : 'safe';
    });
  } catch (e) {
    print('Error fetching records: $e');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Failed to fetch records. Please try again later.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

Future<void> _fetchCameraData() async {
  dynamic data = await CameraServices.getCamera();
  bool hasDisconnectedCamera = data != null && data['data'].any((camera) => camera['status'] == 'disconnected' || camera['status'] == 'inactive');

  setState(() {
    cameraData = data != null ? data['data'] : [];
    if (hasDisconnectedCamera && detectionStatus != 'at_risk') {
      detectionStatus = 'potential';
    }
  });
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(height: 40),
          ),
          Expanded(
            child: FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: 1.0 / 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  color: _getStatusColor(detectionStatus),
                  child: InkWell(
                    onTap: () {
                      // TODO : Handle card tap
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Fire Detection Status: $detectionStatus',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTimeline(),
                    _buildCameraSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    if (_records.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Current active incidents',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              'No recent events',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
    } else {
      final reversedRecords = List.from(_records.reversed);
      final List<Map<String, dynamic>> filteredRecords = reversedRecords.where((record) => record['status'] == 'InAlarm' || record['status'] == 'InVote').toList().cast<Map<String, dynamic>>();

      if (filteredRecords.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Current active incidents',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'No active incidents',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Current active incidents',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              physics: PageScrollPhysics(),
              itemCount: filteredRecords.length > 5 ? 5 : filteredRecords.length,
              itemBuilder: (context, index) {
                final record = filteredRecords[index];
                final DateTime recordDateTime = DateTime.parse(record['recordTime']);
                final String formattedDateTime =
                    '${recordDateTime.day}/${recordDateTime.month}/${recordDateTime.year} ${recordDateTime.hour}:${recordDateTime.minute}';
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActionPage(recordId: record['id']),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Date & Time: $formattedDateTime'),
                    subtitle: Text('Status: ${record['status']}'),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Widget _buildCameraSection() {
    List<dynamic> filteredCameraData = cameraData.where((camera) => camera['status'] == 'disconnected' || camera['status'] == 'inactive').toList();

    if (filteredCameraData.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Disconnected Cameras',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              'No inactive camera',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Disconnected Cameras',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 165,
          child: ListView.builder(
            physics: PageScrollPhysics(),
            itemCount: filteredCameraData.length > 5 ? 5 : filteredCameraData.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Text(
                    'Camera Name: ${filteredCameraData[index]['cameraName']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        'Status: ${filteredCameraData[index]['status']}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Camera Destination: ${filteredCameraData[index]['cameraDestination']}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Camera ID: ${filteredCameraData[index]['cameraId']}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // TODO : Show camera preview ?
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  Color _getStatusColor(String status) {
    switch (status) {
      case 'safe':
        return Colors.green;
      case 'potential':
        return Colors.yellow;
      case 'at_risk':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
