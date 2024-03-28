import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _accessToken = '';

  String get accessToken => _accessToken;

  set accessToken(String value) {
    _accessToken = value;
    notifyListeners();
  }
}