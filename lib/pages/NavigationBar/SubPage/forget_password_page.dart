import 'package:flutter/material.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/confirm_password_page.dart';

class SecurityCodePage extends StatefulWidget {
  @override
  _SecurityCodePageState createState() => _SecurityCodePageState();
}

class _SecurityCodePageState extends State<SecurityCodePage> {
  TextEditingController securityCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Security Code'),
        backgroundColor: Colors.red, // Fire-like color
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Please enter your security code:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: securityCodeController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Security Code',
                hintText: 'Enter your security code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String securityCode = securityCodeController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                );
                print('Entered security code: $securityCode');
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    securityCodeController.dispose();
    super.dispose();
  }
}
