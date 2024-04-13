import 'package:flutter/material.dart';
import 'package:facs_mobile/services/camera_services.dart';

class FixCameraPage extends StatelessWidget {
  final String cameraId;
  final String cameraName;
  final String status;
  final String cameraDestination;

  const FixCameraPage({
    Key? key,
    required this.cameraId,
    required this.cameraName,
    required this.status,
    required this.cameraDestination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fix Camera'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Camera Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Camera ID: $cameraId'),
            Text('Camera Name: $cameraName'),
            Text('Status: $status'),
            Text('Destination: $cameraDestination'),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              child: Text('Fix Camera'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Fix Camera'),
          content: Text('Are you sure this camera is fixed?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await CameraServices.fixCamera(cameraId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Camera has been fixed successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FixCameraPage(
                      cameraId: cameraId,
                      cameraName: cameraName,
                      status: status,
                      cameraDestination: cameraDestination,
                    ),
                  ),
                );
              },
              child: Text('Fix this camera'),
            ),
          ],
        );
      },
    );
  }
}
