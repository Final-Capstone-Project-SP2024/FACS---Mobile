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
}
