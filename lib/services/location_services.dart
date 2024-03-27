import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_services.dart';

class LocationServices {
  static const String apiUrl =
      'https://firealarmcamerasolution.azurewebsites.net/api/v1';

  static Future<dynamic> getLocation() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/Location'),
          headers: {'Authorization': 'Bearer ${UserServices.accessToken}'});

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<dynamic> getLocationDetail(String locationId) async {
    try {
      final response =
          await http.get(Uri.parse('$apiUrl/Location/$locationId'));
      if (response.statusCode == 200) {
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
