import 'package:flutter/material.dart';
import 'package:facs_mobile/services/user_services.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/forget_password_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController securityCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

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
              if (!(ModalRoute.of(context)?.canPop ?? false))
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
                obscureText: !showPassword,
                style: TextStyle(color: Colors.black),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  _signIn();
                },
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SecurityCodePage()),
                      );
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: Colors.blue,
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
                    color: Colors.red,
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
      await saveCredentials(securityCode, password);
      Navigator.pushNamed(context, "/home");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in. Please try again.'),
        ),
      );
    }
  }

  Future<void> saveCredentials(String securityCode, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('securityCode', securityCode);
    await prefs.setString('password', password);
    await prefs.setBool('onboardingCompleted', true);
  }

  Future<void> checkSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedSecurityCode = prefs.getString('securityCode');
    String? savedPassword = prefs.getString('password');

    if (savedSecurityCode != null && savedPassword != null) {
      await _signInWithSavedCredentials(savedSecurityCode, savedPassword);
    }
  }

  Future<void> _signInWithSavedCredentials(
      String securityCode, String password) async {
    Map<String, dynamic>? userData =
        await UserServices.signIn(securityCode, password);

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
  void initState() {
    super.initState();
    checkSavedCredentials();
  }

  @override
  void dispose() {
    securityCodeController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
