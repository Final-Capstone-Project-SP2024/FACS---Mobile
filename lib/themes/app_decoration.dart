import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray30001,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray100,
      );

  static BoxDecoration get fillGrayDecor => BoxDecoration(
        color: appTheme.gray300.withOpacity(0.4),
      );

// Outline decorations
  static BoxDecoration get outlineErrorContainer => BoxDecoration();
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder4 => BorderRadius.circular(
        4.h,
      );
}
