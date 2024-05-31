import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static const String apiUrl =
      'https://firealarmcamerasolution.azurewebsites.net/api/v1/User';
  static String accessToken = '';
  static String refreshToken = '';
  static String fcmToken = '';
  static String userId = '';
  static String userFullname = '';
  static String userRole = '';

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
        final responseData = jsonDecode(response.body);
        accessToken = responseData['data']['accessToken'];
        refreshToken = responseData['data']['refreshToken'];
        sendFCMToken();
        userId = responseData['data']['id'];
        userFullname = responseData['data']['name'];
        userRole = responseData['data']['role']['roleName'];
        saveCredentials(
            accessToken, refreshToken, userId, userFullname, userRole);
        return responseData['data'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<void> saveCredentials(String accessToken, String refreshToken,
      String userId, String userFullname, String userRole) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
    await prefs.setString('userId', userId);
    await prefs.setString('userFullname', userFullname);
    await prefs.setString('userRole', userRole);
  }

  static Future sendFCMToken() async {
    try {
      return await http.post(
          Uri.parse(
              'https://firealarmcamerasolution.azurewebsites.net/api/v1/Token?token=$fcmToken'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          });
    } catch (e) {
      print('Error in savetoken: $e');
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
    try {
      final response = await http.post(Uri.parse('$apiUrl/$userId'),
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

  static Future<bool> forgetPasswordRequest(String securityCode) async {
    try {
      final response = await http
          .post(Uri.parse('$apiUrl/forgetpassword?securityCode=$securityCode'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  static Future<bool> changePasswordRequest(String otp, String newPassword,
      String newPasswordConfirm, String securityCode) async {
    if (newPassword != newPasswordConfirm) {
      return false;
    }
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/otpconfirm'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'securityCode': securityCode,
          'otpSending': otp,
          'newPassword': newPassword
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
