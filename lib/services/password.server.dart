import 'dart:convert';
import 'package:http/http.dart' as http;

class PasswordServicer {
  static const String apiUrl =
      "https://firealarmcamerasolution.azurewebsites.net/api/v1";
  static Future<dynamic> ChangePassword(String securityCode) async {
    try {
      final response = await http
          .post(Uri.parse('$apiUrl/forgetpassword?securityCode=$securityCode'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error : $e');
      return null;
    }
  }

  static Future<bool> ConfirmPassword(
      String securityCode, String confirmKey, String newpassword) async {
    try {
      final response = await http.post(Uri.parse('$apiUrl/otpconfirm'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'securityCode': securityCode,
            'otpSending': confirmKey,
            'newPassword': newpassword
          }));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
