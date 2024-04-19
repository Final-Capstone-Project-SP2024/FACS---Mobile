import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/themes/app_decoration.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:facs_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:facs_mobile/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class LocationListShow extends StatelessWidget {
  LocationListShow({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        // appBar: _appBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 50.v),
              CustomImageView(
                imagePath: ImageConstant.imageLocationRectangle2,
                height: 260.v,
                width: 375.h,
              ),
              _locationElement(context, locationName: "Location A"),
              SizedBox(height: 22.v),
              CustomImageView(
                imagePath: ImageConstant.imageLocationRectangle,
                height: 260.v,
                width: 375.h,
              ),
              _locationElement(context, locationName: "Location B"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _locationElement(BuildContext context, {required String locationName}) {
  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.symmetric(
      horizontal: 21.h,
      vertical: 14.v,
    ),
    decoration: AppDecoration.fillGray,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 3.h,
            top: 5.v,
            bottom: 7.v,
          ),
          child: Text(
            locationName,
            style: theme.textTheme.titleMedium!
                .copyWith(color: theme.colorScheme.onPrimary),
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgCameraOnprimary,
          height: 28.adaptSize,
          width: 28.adaptSize,
          margin: EdgeInsets.only(top: 4.v),
        )
      ],
    ),
  );
}

PreferredSizeWidget _appBar(BuildContext context) {
  return CustomAppBar();
}
