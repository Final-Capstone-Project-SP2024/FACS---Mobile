import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/action_page.test.dart';
import 'package:facs_mobile/services/record_service.dart';
import 'package:facs_mobile/themes/app_decoration.dart';
import 'package:facs_mobile/themes/custom_bottom_style.dart';
import 'package:facs_mobile/themes/custom_text_style.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:facs_mobile/widgets/custom_evulated_bottom.test.dart';
import 'package:facs_mobile/widgets/custom_icon_button.dart';
import 'package:facs_mobile/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_text_form_field.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class RecordDetailUserRoleEightScreen extends StatefulWidget {
  final String recordId;
  final String state;

  const RecordDetailUserRoleEightScreen(
      {super.key, required this.recordId, required this.state});

  @override
  _RecordDetailPageState createState() => _RecordDetailPageState();
}

class _RecordDetailPageState extends State<RecordDetailUserRoleEightScreen> {
  dynamic recordDetailResponse;
  bool _showVideo = false;
  late VideoPlayerController _videoController;
  bool _isPlaying = false;
  int _vote = 0;
  TextEditingController locationController = TextEditingController();

  TextEditingController colortexboxoneController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getRecordDetailId(widget.recordId);
    _initializeVideoController();
  }

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
              child: Column(
                children: [
                  _showVideo ? _showVideoWidget(context) : _showImage(context),
                  //  _buildRowovaltwoone(context),
                  SizedBox(height: 1.v),
                  _buildRowcameraone(context),
                  SizedBox(height: 5.v),
                  _buildUiboxmini(context),
                  SizedBox(height: 10.v),
                  _buildColumntypesomet(context),
                  SizedBox(height: 21.v),
                  _buildColumntypesomet1(context),
                  SizedBox(height: 5.v),
                  _actionPhase(context),
                  SizedBox(height: 5.v),
                  _confirmButton(context),
                ],
              ),
            ),
          ),
        ),
        //   bottomNavigationBar: _buildBottombar(context),
      ),
    );
  }

  void _initializeVideoController() {
    _videoController = VideoPlayerController.network(
        //"https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/VideoRecord%2F${recordDetailResponse['videoRecord']['videoUrl']}?alt=media&token=93976c11-1da7-4aa7-a470-20e26a92a38c",
        //"https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/VideoRecord%2Fincident_12-4-2024-18-47-29.mp4?alt=media&token=93976c11-1da7-4aa7-a470-20e26a92a38c"
        "https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/VideoRecord%2Fcamera_0_2024-04-13_15-20-52.mp4?alt=media&token=18e13091-0a41-4b0e-9b9c-283fb2f3a803")
      ..initialize().then((_) {
        setState(() {});
      });
  }

  Future<dynamic> getRecordDetailId(String recordId) async {
    print(recordId);
    print('');
    var data = await RecordService.getRecordDetail(recordId);
    setState(() {
      if (data != null) {
        recordDetailResponse = data['data'];
        print(recordDetailResponse);
        //_initializeVideoController();
      }
    });
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

  Widget _showVideoWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.h,
        vertical: 14.v,
      ),
      decoration: AppDecoration.fillBlueGray,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_videoController.value.isPlaying) {
                    _videoController.pause();
                  } else {
                    _videoController.play();
                  }
                });
              },
              child: Container(
                color: Colors.black,
                child: _videoController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController),
                      )
                    : Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.h,
        vertical: 14.v,
      ),
      decoration: AppDecoration.fillBlueGray,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Add your code to navigate to another page here
              },
              child: Container(
                color: Colors.black,
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/ImageRecord%2Ffire_0_2024-04-13_14-52-34.jpg?alt=media&token=7b30179f-3ec9-4e33-956d-7ad737aeb82f',
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: 200, // Maximum input size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowcameraone(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.fillGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomImageView(
            color: Colors.amber,
            imagePath: ImageConstant.barInRecordDetail,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.only(top: 23.v),
          ),
          Spacer(
            flex: 29,
          ),
          Padding(
            padding: EdgeInsets.only(top: 23.v),
            child: Text(
              "Media Record",
              style: theme.textTheme.titleLarge,
            ),
          ),
          Spacer(
            flex: 70,
          ),
          // CustomImageView(
          //   imagePath: ImageConstant.imgUpload,
          //   height: 25.v,
          //   width: 30.h,
          //   margin: EdgeInsets.only(
          //     top: 1.v,
          //     bottom: 2.v,
          //   ),
          // ),
          // CustomImageView(
          //   imagePath: ImageConstant.imgImage3,
          //   height: 28.v,
          //   width: 35.h,
          //   margin: EdgeInsets.only(
          //     right: 1.h,
          //     bottom: 2.v,
          //   ),
          // )
          Padding(
            padding: EdgeInsets.only(top: 23.v),
            child: CustomIconButton(
              decoration: AppDecoration.fillGray,
              height: 24.adaptSize,
              width: 24.adaptSize,
              child: CustomImageView(
                imagePath: ImageConstant.imgCameraOnprimary,
              ),
              onTap: () {
                setState(() {
                  _showVideo = true;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.h,
              top: 23.v,
            ),
            child: CustomIconButton(
              decoration: AppDecoration.fillGray,
              height: 24.adaptSize,
              width: 24.adaptSize,
              child: CustomImageView(
                imagePath: ImageConstant.imgUpload,
              ),
              onTap: () {
                setState(() {
                  _showVideo = false;
                });
              },
            ),
          ),
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
              recordDetailResponse['status'],
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
              typesomething1: recordDetailResponse['cameraName'],
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
              typesomething1: recordDetailResponse['cameraDestination'],
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
              typesomething1:
                  recordDetailResponse['predictedPercent'].toString(),
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
