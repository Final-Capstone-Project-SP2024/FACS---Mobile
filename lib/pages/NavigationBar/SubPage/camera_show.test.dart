import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/themes/app_decoration.dart';
import 'package:facs_mobile/themes/custom_text_style.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:facs_mobile/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class CameraList extends StatelessWidget {
  const CameraList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 104.v,
          width: 145.h,
          decoration: BoxDecoration(color: appTheme.blueGray30001),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 9.h,
            vertical: 8.v,
          ),
          decoration: AppDecoration.fillGray,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 1.h, top: 2.v, bottom: 2.v),
                child: Text(
                  "Camera_001",
                  style: CustomTextStyles.titleSmallOnPrimary,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgCameraOnprimary,
                height: 24.adaptSize,
                width: 24.adaptSize,
                margin: EdgeInsets.only(left: 30.h),
              )
            ],
          ),
        ),
      ],
    );
  }
}
