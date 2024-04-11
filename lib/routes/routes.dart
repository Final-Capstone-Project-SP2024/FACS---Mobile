
import 'package:flutter/material.dart';

import 'package:facs_mobile/pages/onBoarding.dart';
import 'package:facs_mobile/pages/sign_in.dart';
import 'package:facs_mobile/pages/home_page.dart';
import 'package:facs_mobile/pages/profile_page.dart';
import 'package:facs_mobile/pages/notification_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/onboarding":
      return MaterialPageRoute(builder: (context) => OnBoarding());
    case "/signin":
      return MaterialPageRoute(builder: (context) => SignIn());
    case "/home":
      return MaterialPageRoute(builder: (context) => HomePage());
    case "/profile":
      return MaterialPageRoute(builder: (context) => ProfilePage());
    case "/notification":
      return MaterialPageRoute(builder: (context) => NotificationPage());
    default:
      return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(title: Text('Error')),
      body: Center(child: Text('Page not found')),
    ),
  );
}
