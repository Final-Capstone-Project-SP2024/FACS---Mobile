import 'package:flutter/material.dart';
import 'package:facs_mobile/services/camera_services.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<dynamic> cameraData = [];

  @override
  void initState() {
    super.initState();
    fetchCameraData();
  }

  Future<void> fetchCameraData() async {
    dynamic data = await CameraServices.getCamera();

    setState(() {
      cameraData = data != null ? data['data'] : [];
    });
  }

  Color getStatusColor(String status) {
    if (status == 'Disconnected' || status == 'Inactive') {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(height: 50),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cameraData.length,
              itemBuilder: (context, index) {
                String status = cameraData[index]['status'];
                Color cardColor = getStatusColor(status);

                return Card(
                  elevation: 4,
                  color: cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Text(
                      'Camera Name: ${cameraData[index]['cameraName']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Status: $status',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Camera Destination: ${cameraData[index]['cameraDestination']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
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
      ),
    );
  }
}
