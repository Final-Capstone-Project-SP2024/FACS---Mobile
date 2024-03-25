import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationServices {
  static const String apiUrl = 'https://firealarmcamerasolution.azurewebsites.net/api/v1';

  static Future<dynamic> getLocation() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/Location'),
      );

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
