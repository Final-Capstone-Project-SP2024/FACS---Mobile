import 'dart:convert';
import 'package:http/http.dart' as http;

class UserServices {
  static const String apiUrl =
      'https://firealarmcamerasolution.azurewebsites.net/api/v1/User';
  static String accessToken = '';
  static String refreshToken = '';
  static String userId = '';
  // static String userFullname = '';
  // static String phone = '';
  // static String email = '';

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
        userId = responseData['data']['id'];
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
  static Future<bool> updateUserProfile({
    required String email,
    required String phone,
    required String name,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'phone': phone,
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update profile: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
  Future<Map<String, dynamic>> getUserDetails(String userId) async {
    final String url = '$apiUrl/$userId';

    try {
      final response = await http.get(Uri.parse('$url'),
        headers: {'Authorization': 'Bearer ${UserServices.accessToken}'});
      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        return userData;
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
