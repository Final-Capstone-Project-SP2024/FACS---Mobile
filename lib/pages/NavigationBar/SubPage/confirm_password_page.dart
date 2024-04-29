import 'package:facs_mobile/pages/sign_in.dart';
import 'package:facs_mobile/services/user_services.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  final String SecurityCode;
  const ResetPasswordPage({super.key, required this.SecurityCode});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController keyController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Enter the key, new password, and confirm new password:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: keyController,
              decoration: InputDecoration(
                labelText: 'OTP',
                hintText: 'Enter the OTP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                hintText: 'Enter the new password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: confirmNewPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                hintText: 'Confirm the new password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String key = keyController.text;
                String newPassword = newPasswordController.text;
                String confirmNewPassword = confirmNewPasswordController.text;

                print('Key: $key');
                print('New Password: $newPassword');
                print('Confirm New Password: $confirmNewPassword');
                Future<bool> check = UserServices.changePasswordRequest(
                    key, newPassword, confirmNewPassword, widget.SecurityCode);

                if (await check) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Wrong OTP or Password not matching'),
                    ),
                  );
                }
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Fire-like color
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    keyController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }
}
