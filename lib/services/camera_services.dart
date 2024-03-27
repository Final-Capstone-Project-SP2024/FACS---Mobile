import 'dart:convert';
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

  static Future<bool> addCamera({
    required String status,
    required String destination,
    required String locationId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/Camera'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'status': status,
          'destination': destination,
          'locationId': locationId,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<bool> deleteCamera(String cameraId) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/Camera/$cameraId'),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
