import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'user_services.dart';

class CameraServices {
  static const String apiUrl =
      'https://firealarmcamerasolution.azurewebsites.net/api/v1';
  static int userIdCounter = 0;
  static Future<dynamic> getCamera() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/Camera'),
          headers: {'Authorization': 'Bearer ${UserServices.accessToken}'});

      if (response.statusCode == 200) {
        userIdCounter++;

        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<void> sendAlert(List<int> imageData, List<int> videoData, String cameraId, int fireDetection) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/Camera/$cameraId/alert'),
      );

      // Add authorization token to the headers
      request.headers['Authorization'] = 'Bearer $UserServices.accessToken';

      // Add the image data as a file field to the request
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageData,
          filename: 'image.jpg',
        ),
      );

      // Add the video data as a file field to the request
      request.files.add(
        http.MultipartFile.fromBytes(
          'video',
          videoData,
          filename: 'video.mp4',
        ),
      );

      // Add fire detection as a field
      request.fields['FireDetection'] = fireDetection.toString();

      // Send the request
      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('Alert sent successfully');
      } else {
        print('Failed to send alert. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in sendAlert: $e');
    }
  }
}
