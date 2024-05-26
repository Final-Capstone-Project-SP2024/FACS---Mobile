import 'package:facs_mobile/pages/NavigationBar/SubPage/picture_preview_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class AddEvidencePage extends StatefulWidget {
  final String recordId;
  AddEvidencePage({Key? key, required this.recordId}) : super(key: key);
  @override
  _AddEvidencePageState createState() => _AddEvidencePageState();
}

class _AddEvidencePageState extends State<AddEvidencePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      _initializeCamera();
    } else {
      print('Camera permission not granted');
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox.expand(
                  child: CameraPreview(_controller),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 16),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Take a picture as an evidence',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  _takePicture(widget.recordId); // Pass the recordId here
                },
                child: Icon(
                  Icons.photo_camera,
                  color: Colors.lightBlue,
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  shape: CircleBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _takePicture(String recordId) async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PicturePreviewPage(
            imagePath: image.path,
            recordId: recordId,
          ),
        ),
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
  }
}
