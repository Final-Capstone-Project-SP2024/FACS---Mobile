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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Page'),
      ),
      body: ListView.builder(
        itemCount: cameraData.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(
                'Camera Name: ${cameraData[index]['cameraName']}',
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
                    'Status: ${cameraData[index]['status']}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Camera Destination: ${cameraData[index]['cameraDestination']}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Camera ID: ${cameraData[index]['cameraId']}',
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
    );
  }
}
