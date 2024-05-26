import 'dart:io';
import 'package:facs_mobile/services/record_service.dart';
import 'package:flutter/material.dart';

class PicturePreviewPage extends StatelessWidget {
  final String imagePath;
  final String recordId;

  const PicturePreviewPage({required this.imagePath, required this.recordId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(imagePath)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final bytes = File(imagePath).readAsBytesSync();
                await RecordService.addEvidence(bytes, recordId);
              },
              child: Text('Send Image'),
            ),
          ],
        ),
      ),
    );
  }
}
