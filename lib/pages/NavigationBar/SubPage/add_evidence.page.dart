import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:facs_mobile/services/record_service.dart';

class AddEvidencePage extends StatelessWidget {
  final String recordIdAdding;
  AddEvidencePage({required this.recordIdAdding});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fire Detection Evidence',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        hintColor: Colors.yellowAccent,
        fontFamily: 'Roboto',
      ),
      home: TakePictureScreen(
        recordId: recordIdAdding,
      ),
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  final String recordId;
  TakePictureScreen({required this.recordId});

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  File? _imageFile;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _sendPicture() async {
    if (_imageFile != null) {
      try {
        // Read image file as bytes
        List<int> imageBytes = await _imageFile!.readAsBytes();

        // Call RecordService.addEvidence to send the image data
        await RecordService.addEvidence(imageBytes, widget.recordId);
      } catch (e) {
        print('Failed to send picture: $e');
      }
    } else {
      print('No image to send.');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Picture sent successfully')),
    );
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Detection Evidence'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: _imageFile == null
                ? Text(
                    'No image selected.',
                    style: TextStyle(fontSize: 20),
                  )
                : Image.file(
                    _imageFile!,
                    height: 300,
                    width: 300,
                  ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _sendPicture,
            child: Text('Send Picture'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        tooltip: 'Take Picture',
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
