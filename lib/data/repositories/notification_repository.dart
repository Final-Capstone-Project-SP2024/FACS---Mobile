import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:facs_mobile/data/helpers/access_token_helper.dart';

class NotificationRepository {
  static const String apiUrl =
      'https://firealarmcamerasolution.azurewebsites.net/api/v1';

  static Future<dynamic> getNotification() async {
    try {
      final response =
          await http.get(Uri.parse('$apiUrl/Notification/firealarms'));
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error : $e');
      return null;
    }
  }

  static Future<bool> isAlarm() async {
    final response = await http
        .get(Uri.parse('$apiUrl/Notification/firealarms'), headers: {
      'Authorization': 'Bearer ${AccessTokenHelper.getAccessToken()}'
    });
    return true;
  }

  static Future<dynamic> getDisconnectedAlarms() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/Notification/disconnectedalarms'),
        headers: {
          'Authorization': 'Bearer ${AccessTokenHelper.getAccessToken()}'
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
