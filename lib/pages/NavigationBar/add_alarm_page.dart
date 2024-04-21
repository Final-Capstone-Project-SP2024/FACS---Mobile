// import 'dart:io';
// import 'package:facs_mobile/services/camera_services.dart';
// import 'package:flutter/material.dart';
// import 'package:facs_mobile/services/location_services.dart';
// import 'package:facs_mobile/pages/NavigationBar/SubPage/use_camera_page.dart';

// class AddAlarmPage extends StatefulWidget {
//   const AddAlarmPage({Key? key}) : super(key: key);
//   @override
//   _AddAlarmPageState createState() => _AddAlarmPageState();
// }

// class _AddAlarmPageState extends State<AddAlarmPage> {
//   String? _selectedLocation;
//   List<Map<String, String>> _locations = [];
//   String? _selectedCamera;
//   List<Map<String, String>> _cameras = [];
//   bool _mediaAvailable = false;
//   int _fireRating = 1;
//   File? video;
//   File? image;

//   @override
//   void initState() {
//     super.initState();
//     _fetchLocations();
//   }

//   Future<void> _fetchLocations() async {
//     try {
//       final response = await LocationServices.getLocation();
//       if (response != null) {
//         if (response.containsKey('data')) {
//           List<dynamic> data = response['data'];
//           List<Map<String, String>> locations = [];
//           for (var locationData in data) {
//             String locationId = locationData['locationId'];
//             String locationName = locationData['locationName'];
//             locations
//                 .add({'locationId': locationId, 'locationName': locationName});
//           }
//           setState(() {
//             _locations = locations;
//           });
//         }
//       }
//     } catch (e) {
//       print('Error fetching locations: $e');
//     }
//   }

//   Future<void> _fetchCameras(String locationId) async {
//     try {
//       final response = await LocationServices.getLocationDetail(locationId);
//       if (response != null && response.containsKey('data')) {
//         List<dynamic> cameraData = response['data']['cameraInLocations'];
//         List<Map<String, String>> cameras = [];
//         for (var camera in cameraData) {
//           String cameraId = camera['cameraId'];
//           String cameraName =
//               '${camera['cameraName']} - ${camera['cameraDestination']}';
//           cameras.add({'cameraId': cameraId, 'cameraName': cameraName});
//         }
//         setState(() {
//           _cameras = cameras;
//           if (_cameras.isNotEmpty) {
//             _selectedCamera = _cameras.first['cameraId'];
//           }
//         });
//       }
//     } catch (e) {
//       print('Error fetching cameras: $e');
//     }
//   }

//   // void _navigateToCameraPage() async {
//   //   final capturedMedia = await Navigator.push(
//   //     context,
//   //     // MaterialPageRoute(builder: (context) => UseCameraPage()),
//   //   );
//   //   if (capturedMedia != null &&
//   //       capturedMedia is List<File?> &&
//   //       capturedMedia.length == 2) {
//   //     setState(() {
//   //       image = capturedMedia[0];
//   //       video = capturedMedia[1];
//   //     });
//   //   } else {
//   //     print('User canceled camera');
//   //   }
//   // }

//   Future<void> _sendAlert(File? imageFile, File? videoFile, String cameraId,
//       int fireDetection) async {
//     try {
//       if ((imageFile != null && imageFile is File) ||
//           (videoFile != null && videoFile is File)) {
//         List<int> imageData = [];
//         List<int> videoData = [];

//         if (imageFile != null) {
//           imageData = await imageFile.readAsBytes();
//         }

//         if (videoFile != null) {
//           videoData = await videoFile.readAsBytes();
//         }
//         await CameraServices.sendAlert(
//             imageData, videoData, cameraId, fireDetection);
//       } else {
//         print(
//             'Error: Either imageFile or videoFile must be provided and must be of type File');
//       }
//     } catch (e) {
//       print('Error in _sendAlert: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Select Location',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: DropdownButton<String>(
//                 value: _selectedLocation,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedLocation = newValue;
//                     if (newValue != null) {
//                       _fetchCameras(newValue);
//                     }
//                   });
//                 },
//                 items: _locations.map<DropdownMenuItem<String>>(
//                     (Map<String, String> location) {
//                   return DropdownMenuItem<String>(
//                     value: location['locationId']!,
//                     child: Text(location['locationName']!),
//                   );
//                 }).toList(),
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Select Camera',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: DropdownButton<String>(
//                 value: _selectedCamera,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedCamera = newValue;
//                   });
//                 },
//                 items: _cameras.map<DropdownMenuItem<String>>(
//                     (Map<String, String> camera) {
//                   return DropdownMenuItem<String>(
//                     value: camera['cameraId']!,
//                     child: Text(camera['cameraName']!),
//                   );
//                 }).toList(),
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               //    onPressed: _mediaAvailable ? null : _navigateToCameraPage,
//               child: Text('Add video/picture'),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Rate Fire',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: DropdownButton<int>(
//                 value: _fireRating,
//                 onChanged: (int? newValue) {
//                   setState(() {
//                     _fireRating = newValue!;
//                   });
//                 },
//                 items: List.generate(100, (index) {
//                   return DropdownMenuItem<int>(
//                     value: index + 1,
//                     child: Text('${index + 1}'),
//                   );
//                 }),
//               ),
//             ),
//             SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () {
//                 String cameraId = _selectedCamera ?? '';
//                 _sendAlert(image, video, cameraId, _fireRating);
//               },
//               child: Text('Send alert'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
