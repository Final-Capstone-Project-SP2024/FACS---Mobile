import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:facs_mobile/data/helpers/access_token_helper.dart';

class LocationRepository {
  static const String apiUrl =
      'https://firealarmcamerasolution.azurewebsites.net/api/v1';

  static Future<dynamic> getLocation() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/Location'), headers: {
        'Authorization': 'Bearer ${AccessTokenHelper.getAccessToken()}'
      });

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

  static Future<Map<String, dynamic>> getLocationData(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load location data');
    }
  }
}
