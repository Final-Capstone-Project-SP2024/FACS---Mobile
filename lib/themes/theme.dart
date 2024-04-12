import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var customLightTheme = ThemeData(
  scaffoldBackgroundColor: Color.fromARGB(255, 239, 250, 246),
  primarySwatch: Colors.deepPurple,
  fontFamily: GoogleFonts.lato().fontFamily,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
);

var customDarkTheme = ThemeData(
  //brightness: Brightness.dark,
  scaffoldBackgroundColor: Color.fromARGB(255, 239, 250, 246),
  primarySwatch: Colors.deepPurple,
  fontFamily: GoogleFonts.lato().fontFamily,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
);
