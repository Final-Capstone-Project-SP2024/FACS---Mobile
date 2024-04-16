import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/action_page.test.dart';
import 'package:facs_mobile/themes/app_decoration.dart';
import 'package:facs_mobile/themes/custom_bottom_style.dart';
import 'package:facs_mobile/themes/custom_text_style.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:facs_mobile/widgets/custom_evulated_bottom.test.dart';
import 'package:facs_mobile/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_text_form_field.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class RecordDetailUserRoleEightScreen extends StatelessWidget {
  RecordDetailUserRoleEightScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController locationController = TextEditingController();

  TextEditingController colortexboxoneController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    _buildRowovaltwoone(context),
                    _buildRowcameraone(context),
                    SizedBox(height: 5.v),
                    _buildUiboxmini(context),
                    SizedBox(height: 10.v),
                    _buildColumntypesomet(context),
                    SizedBox(height: 21.v),
                    _buildColumntypesomet1(context),
                    SizedBox(height: 5.v),
                    _votePart(context),
                    SizedBox(height: 5.v),
                    _actionPhase(context),
                    SizedBox(height: 5.v),
                    _confirmButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
        //   bottomNavigationBar: _buildBottombar(context),
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

  /// Section Widget
  Widget _buildRowovaltwoone(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 18.h,
        vertical: 14.v,
      ),
      decoration: AppDecoration.fillBlueGray,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 10.adaptSize,
            width: 10.adaptSize,
            margin: EdgeInsets.only(
              top: 217.v,
              bottom: 3.v,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(
                5.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.h,
              top: 212.v,
            ),
            child: Text(
              "16:20:35",
              style: CustomTextStyles.titleMediumWhiteA700,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowcameraone(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 28.h,
        vertical: 15.v,
      ),
      decoration: AppDecoration.fillGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgCameraOnprimary,
            height: 27.v,
            width: 32.h,
            margin: EdgeInsets.only(
              top: 1.v,
              bottom: 2.v,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgUpload,
            height: 25.v,
            width: 30.h,
            margin: EdgeInsets.only(
              top: 1.v,
              bottom: 2.v,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage3,
            height: 28.v,
            width: 35.h,
            margin: EdgeInsets.only(
              right: 1.h,
              bottom: 2.v,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _actionPhase(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Action Level",
            style: CustomTextStyles.titleLargeBluegray300,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.h),
            child: _buildColortexbox(
              context,
              levelCounter: "XXX_001",
              typesomething: "1",
            ),
          ),
          SizedBox(height: 3.v),
          Container(
            margin: EdgeInsets.only(left: 15.h),
            decoration: AppDecoration.fillWhiteA,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.v),
                Padding(
                  padding: EdgeInsets.only(right: 30.h),
                  child: _buildRowtypesomethin(
                    context,
                    levelCounter: "XXX_002",
                    typesomething: "2",
                  ),
                ),
                Divider()
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUiboxmini(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 17.h,
        vertical: 2.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.h,
              top: 2.v,
              bottom: 2.v,
            ),
            child: Text(
              "InAlarm",
              style: theme.textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.v),
            child: Text(
              "10/08/2018",
              style: theme.textTheme.titleMedium,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumntypesomet(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 24.v,
              width: 70.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Camera",
                      style: CustomTextStyles.titleLargeBluegray300,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Camera",
                      style: CustomTextStyles.titleLargeBluegray300,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 4.v),
          Padding(
            padding: EdgeInsets.only(
              left: 18.h,
              right: 32.h,
            ),
            child: _buildColorwhite(
              context,
              typesomething: "Location",
              typesomething1: "Location A",
            ),
          ),
          SizedBox(height: 1.v),
          Padding(
            padding: EdgeInsets.only(
              left: 18.h,
              right: 32.h,
            ),
            child: _buildColorwhite(
              context,
              typesomething: "Camera Name",
              typesomething1: "camera_000",
            ),
          ),
          SizedBox(height: 1.v),
          Padding(
            padding: EdgeInsets.only(
              left: 18.h,
              right: 32.h,
            ),
            child: _buildColorwhite(
              context,
              typesomething: "Camera Destination",
              typesomething1: "Left",
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumntypesomet1(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Analysis",
              style: CustomTextStyles.titleLargeBluegray300,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15.h,
              right: 31.h,
            ),
            child: _buildColorwhite(
              context,
              typesomething: "AI Predicted",
              typesomething1: "78.20",
            ),
          ),
          SizedBox(height: 3.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _votePart(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vote",
            style: CustomTextStyles.titleLargeBluegray300,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.h),
            child: _buildColortexbox(
              context,
              levelCounter: "XXX_001",
              typesomething: "1",
            ),
          ),
          SizedBox(height: 3.v),
          Container(
            margin: EdgeInsets.only(left: 15.h),
            decoration: AppDecoration.fillWhiteA,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.v),
                Padding(
                  padding: EdgeInsets.only(right: 30.h),
                  child: _buildRowtypesomethin(
                    context,
                    levelCounter: "XXX_002",
                    typesomething: "2",
                  ),
                ),
                Divider()
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottombar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
    );
  }

  Widget _confirmButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.h, right: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomEvulatedBottom(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AlarmPage(), // Replace YourDestinationPage with the page you want to navigate to
                  ),
                );
              },
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

  /// Common widget
  Widget _buildColortexbox(
    BuildContext context, {
    required String levelCounter,
    required String typesomething,
  }) {
    return Container(
      decoration: AppDecoration.fillWhiteA,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.v),
          Padding(
            padding: EdgeInsets.only(right: 32.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1.v),
                  child: Text(
                    levelCounter,
                    style: CustomTextStyles.titleMediumOnPrimary.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.v),
                  child: Text(
                    typesomething,
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: appTheme.blueGray300,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _buildRowtypesomethin(
    BuildContext context, {
    required String levelCounter,
    required String typesomething,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.v),
          child: Text(
            levelCounter,
            style: CustomTextStyles.titleMediumOnPrimary.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 3.v),
          child: Text(
            typesomething,
            style: theme.textTheme.titleSmall!.copyWith(
              color: appTheme.blueGray300,
            ),
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildColorwhite(
    BuildContext context, {
    required String typesomething,
    required String typesomething1,
  }) {
    return Container(
      decoration: AppDecoration.fillWhiteA,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 13.v),
          Padding(
            padding: EdgeInsets.only(right: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  typesomething,
                  style: CustomTextStyles.titleMediumOnPrimary.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.v),
                  child: Text(
                    typesomething1,
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: appTheme.blueGray300,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
