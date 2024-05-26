import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:flutter/material.dart';

class CustomBottomStyle {
  static ButtonStyle get fillGreen => ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 88, 255, 76),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(31.h),
        ),
      );

  static ButtonStyle get fillRed => ElevatedButton.styleFrom(
        backgroundColor: const Color(0XFFff3131),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(31.h),
        ),
      );
  static ButtonStyle get fillYellow => ElevatedButton.styleFrom(
        backgroundColor: const Color(0XFFffd700),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(31.h),
        ),
      );
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
