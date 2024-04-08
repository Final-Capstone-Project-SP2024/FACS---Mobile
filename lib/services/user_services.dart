import 'dart:convert';
import 'package:http/http.dart' as http;

class UserServices {
  static const String apiUrl =
      'https://firealarmcamerasolution.azurewebsites.net/api/v1/User';
  static String accessToken = '';
  static String refreshToken = '';
  static String fcmToken = '';

  static Future<Map<String, dynamic>?> signIn(
      String securityCode, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'securityCode': securityCode,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        print("Login Success");
        final responseData = jsonDecode(response.body);
        accessToken = responseData['data']['accessToken'];
        refreshToken = responseData['data']['refreshToken'];
        //? Sending FCM Token to sytem;
        SendFCMToken();
        return responseData['data'];
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future SendFCMToken() async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://firealarmcamerasolution.azurewebsites.net/api/v1/Token?token=$fcmToken'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          });
    } catch (e) {
      print('Error in savetoke: $e');
    }
  }
}
