// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

// class UseCameraPage extends StatefulWidget {
//   @override
//   _UseCameraPageState createState() => _UseCameraPageState();
// }

// class _UseCameraPageState extends State<UseCameraPage> {
//   late final ImagePicker _imagePicker;
//   File? _image;
//   File? _video;
//   late VideoPlayerController _videoPlayerController;
//   bool _isImageCaptured = false;
//   bool _isVideoCaptured = false;

//   @override
//   void initState() {
//     super.initState();
//     _imagePicker = ImagePicker();
//     _videoPlayerController = VideoPlayerController.asset('assets/placeholder_video.mp4');
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     super.dispose();
//   }

//   // Future<void> _captureImage() async {
//   //   final pickedFile = await _imagePicker.getImage(
//   //     source: ImageSource.camera,
//   //   );

//     setState(() {
//       _image = File(pickedFile!.path);
//       _isImageCaptured = true;
//     });

//     _checkMediaCapture();
//   }

//   // Future<void> _recordVideo() async {
//   //   final pickedFile = await _imagePicker.getVideo(
//   //     source: ImageSource.camera,
//   //   );

//     setState(() {
//       _video = File(pickedFile!.path);
//       _isVideoCaptured = true;
//     });

//     _checkMediaCapture();
//   }

//   void _checkMediaCapture() {
//     if (_isImageCaptured && _isVideoCaptured) {
//       Navigator.pop(context, [_image, _video]);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please capture both image and video.'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Use Camera'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center, // Adjusted here
//           children: [
//             if (_image != null)
//               Image.file(
//                 _image!,
//                 width: 300,
//                 height: 300,
//                 fit: BoxFit.cover,
//               ),
//             if (_video != null)
//               AspectRatio(
//                 aspectRatio: _videoPlayerController.value.aspectRatio,
//                 child: VideoPlayer(_videoPlayerController),
//               ),
//             SizedBox(height: 20),
//             Padding(padding: EdgeInsets.all(10),
//               child: Text(
//                 'Please capture an image AND record a video to continue :',
//                 textAlign: TextAlign.center, // Align the text center
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isImageCaptured ? null : _captureImage,
//               child: Text('Capture Image'),
//             ),
//             ElevatedButton(
//               onPressed: _isVideoCaptured ? null : _recordVideo,
//               child: Text('Record Video'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// }
