import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Title text style
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get titleLargeBluegray300 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray300,
      );

  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );

  static get titleSmallOnPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );

  static get titleSmallPop => theme.textTheme.titleSmall!.poppins
      .copyWith(color: appTheme.blueGray300, fontWeight: FontWeight.w500);

  static get titleAlarm => theme.textTheme.titleMedium!
      .copyWith(color: theme.colorScheme.onPrimary.withOpacity(1));

  static get titleMediumBlueGray30001 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray30001,
      );
}
