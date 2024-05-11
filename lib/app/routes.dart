import 'package:facs_mobile/app/pages/notification_page.dart';
import 'package:flutter/material.dart';

import 'package:facs_mobile/app/pages/onBoarding.dart';
import 'package:facs_mobile/app/pages/sign_in.dart';
import 'package:facs_mobile/app/pages/home_page.dart';
import 'package:facs_mobile/app/pages/profile_page.dart';

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
