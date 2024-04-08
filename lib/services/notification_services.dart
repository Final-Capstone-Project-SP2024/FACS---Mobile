import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:facs_mobile/services/user_services.dart';

class NotificationService {
  static const String apiUrl =
      'https://firealarmcamerasolution.azurewebsites.net/api/v1';

  static Future<dynamic> getNotification() async {
    try {
      final response = await http.get(Uri.parse(
          'https://firealarmcamerasolution.azurewebsites.net/firealarms'));
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
    final response = await http.get(Uri.parse('$apiUrl/firealarms'),
          headers: {'Authorization': 'Bearer ${UserServices.accessToken}'});
    return true;
  }
}
