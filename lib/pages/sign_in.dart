import 'package:flutter/material.dart';
import 'package:facs_mobile/services/user_services.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/forget_password_page.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController securityCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(height: 20),
              Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome Back',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: securityCodeController,
                style: TextStyle(color: Colors.black),
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                  hintText: "Security Code",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  prefixIcon: Icon(Icons.security),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.black),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  _signIn();
                },
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      // Navigate to forget password screen or perform password recovery process
                      // Example: Navigator.pushNamed(context, "/forget_password");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SecurityCodePage()),
                      );
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: Colors.blue, // You can change color as needed
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _signIn,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red, // Fire-like color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String securityCode = securityCodeController.text;
    String password = passwordController.text;
    Map<String, dynamic>? userData =
        await UserServices.signIn(securityCode, password);
    print(userData);
    if (userData != null) {
      Navigator.pushNamed(context, "/home");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in. Please try again.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    securityCodeController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
