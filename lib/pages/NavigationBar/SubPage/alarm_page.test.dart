import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/themes/app_decoration.dart';
import 'package:facs_mobile/themes/custom_text_style.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_leading_image.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_title.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_trailing_image.dart';
import 'package:facs_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:facs_mobile/widgets/custom_evulated_bottom.test.dart';
import 'package:facs_mobile/widgets/custom_image_view.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:flutter/material.dart';

class AlarmByHandPage extends StatelessWidget {
  AlarmByHandPage({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
        child: Scaffold(
      backgroundColor: appTheme.whiteA700,
      appBar: _buildAppBar(context),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomImageView(
            alignment: Alignment.center,
            imagePath: ImageConstant.backGroungImage,
            height: 650.v,
            width: 500.v,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 37.h, top: 46.v, right: 27.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 67.h, vertical: 48.v),
                    decoration: AppDecoration.outlineErrorContainer.copyWith(
                      image: DecorationImage(
                          image: fs.Svg(ImageConstant.circle),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.alarm,
                          height: 121.v,
                          width: 125.v,
                        ),
                        Text(
                          "Fire Alarm ",
                          style: theme.textTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 51.v,
                  ),
                  _buildComlumnDescription(context),
                  SizedBox(
                    height: 52.v,
                  ),
                  CustomEvulatedBottom(
                    buttonStyle: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(int.parse("FF3451", radix: 16))
                              .withOpacity(1.0)),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      // Add more properties as needed
                    ),
                    text: "EMERGENCY",
                    buttonTextStyle: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
    );
  }

  Widget _buildComlumnDescription(BuildContext context) {
    return Container(
      width: 311.h,
      padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 36.v),
      decoration: AppDecoration.fillGrayDecor,
      child: Container(
        width: 297.h,
        margin: EdgeInsets.only(right: 5.h),
        child: Text(
          "When a fie appears, try your hardest \nto remain composed and hit \"Emergency\" \nbutton right  away to warn anyone nearby.",
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: CustomTextStyles.titleAlarm,
        ),
      ),
    );
  }
}
