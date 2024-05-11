import 'package:facs_mobile/app/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CustomBottomStyle {
  static ButtonStyle get fillGreen => ElevatedButton.styleFrom(
        backgroundColor: const Color(0XFF73FD68),
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
