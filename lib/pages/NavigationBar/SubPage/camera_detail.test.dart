import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/camera_list.test.dart';
import 'package:facs_mobile/themes/app_decoration.dart';
import 'package:facs_mobile/themes/custom_text_style.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:facs_mobile/widgets/custom_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraDetail extends StatelessWidget {
  CameraDetail({Key? key}) : super(key: key);

  TextEditingController colortext = TextEditingController();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: appTheme.whiteA700,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imageLocation,
              height: 308.v,
              width: 374.h,
              margin: EdgeInsets.only(left: 1.h),
            ),
            SizedBox(height: 16.v),
            Padding(
              padding: EdgeInsets.only(left: 9.h),
              child: Text(
                "Location B",
                style: theme.textTheme.headlineLarge,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 9.h),
              child: Text(
                "Active",
                style: CustomTextStyles.titleSmallPop,
              ),
            ),
            SizedBox(height: 10.v),
            _title(context),
            SizedBox(height: 16.v),
            _cameraList(context),
            SizedBox(height: 5.v)
          ],
        ),
      ),
    ));
  }

  Widget _title(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.v,
            width: 332.h,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "User and Camera",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 12.h,
              right: 34.h,
            ),
            decoration: AppDecoration.fillWhiteA,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.v),
                Padding(
                  padding: EdgeInsets.only(right: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cameras",
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        "2",
                        style: theme.textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2.v),
                const Divider()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _cameraList(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 9.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Camera",
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(
            height: 7.v,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 70.v,
              child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 12.h),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const CameraListIn();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10.h,
                    );
                  },
                  itemCount: 3),
            ),
          )
        ],
      ),
    );
  }
}
