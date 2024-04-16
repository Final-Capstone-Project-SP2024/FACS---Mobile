import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/listdynamic_item_widget.test.dart';
import 'package:facs_mobile/themes/custom_bottom_style.dart';
import 'package:facs_mobile/themes/custom_text_style.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_leading_image.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_title.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_trailing_image.dart';
import 'package:facs_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:facs_mobile/widgets/custom_evulated_bottom.test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlarmPage extends StatelessWidget {
  AlarmPage({Key? key}) : super(key: key);
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: appTheme.whiteA700,
      appBar: _buildAppbar(context),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 18.v,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 26.v,
            ),
            Text(
              "Choose alarm Level ?",
              style: theme.textTheme.headlineLarge,
              selectionColor: Colors.red,
            ),
            SizedBox(
              height: 13.v,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Action Alarm",
                style: theme.textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: 69.v,
            ),
            _chooseList(context),
            Spacer(),
            _confirmButton(context),
          ],
        ),
      ),
    ));
  }

  Widget _chooseList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.h),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, inedx) {
          return SizedBox(
            height: 4.v,
          );
        },
        itemCount: 4,
        itemBuilder: (context, index) {
          return const ListdynamicItemWidget();
        },
      ),
    );
  }

  Widget _confirmButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 11.h, right: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomEvulatedBottom(
              text: "Confirm ",
              buttonStyle: CustomBottomStyle.fillGreen,
              margin: EdgeInsets.only(right: 22.h),
              buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
            ),
          ),
          Expanded(
            child: CustomEvulatedBottom(
              text: "Cancel",
              buttonStyle: CustomBottomStyle.fillRed,
              margin: EdgeInsets.only(right: 22.h),
              buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDown,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 34.v,
          bottom: 12.v,
        ),
      ),
      title: AppbarTitle(
        text: "Record Detail",
        margin: EdgeInsets.only(
          left: 32.h,
          top: 33.v,
          bottom: 12.v,
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgIconMore,
          margin: EdgeInsets.fromLTRB(14.h, 34.v, 14.h, 12.v),
        )
      ],
    );
  }
}
