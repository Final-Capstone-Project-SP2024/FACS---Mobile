import 'dart:convert';
import 'package:http/http.dart' as http;

class UserServices {
  static const String apiUrl = 'https://firealarmcamerasolution.azurewebsites.net/api/v1/User';
  static String accessToken = '';
  static String refreshToken = '';

  static Future<Map<String, dynamic>?> signIn(String securityCode, String password) async {
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
        final responseData = jsonDecode(response.body);
        accessToken = responseData['data']['accessToken'];
        refreshToken = responseData['data']['refreshToken'];
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
}
