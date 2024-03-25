import 'package:flutter/material.dart';
import 'package:facs_mobile/services/user_services.dart';

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
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Text(
                "Let's Sign you in",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome Back',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 70),
              Container(
                width: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      child: TextField(
                        controller: securityCodeController,
                        style: TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Security Code",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          border: new UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.blueAccent)
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) {
                          _signIn();
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          border: new UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.blueAccent)
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60),
              Container(
                height: 50,
                width: 320,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0)
                ),
                child: GestureDetector(
                  onTap: _signIn,
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String securityCode = securityCodeController.text;
    String password = passwordController.text;
    Map<String, dynamic>? userData = await UserServices.signIn(securityCode, password);
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
