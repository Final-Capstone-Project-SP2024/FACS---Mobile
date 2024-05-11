import 'package:facs_mobile/app/utils/image_constant.dart';
import 'package:facs_mobile/app/utils/size_utils.dart';
import 'package:facs_mobile/services/camera_services.dart';
import 'package:facs_mobile/app/themes/app_decoration.dart';
import 'package:facs_mobile/app/themes/custom_text_style.dart';
import 'package:facs_mobile/app/themes/theme_helper.dart';
import 'package:facs_mobile/app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class CameraDetail extends StatefulWidget {
  final String cameraId;
  final String cameraStatus;
  final String cameraDestination;
  final String cameraName;
  final String cameraImage;
  CameraDetail(
      {Key? key,
      required this.cameraId,
      required this.cameraStatus,
      required this.cameraDestination,
      required this.cameraName,
      required this.cameraImage})
      : super(key: key);

  TextEditingController colortext = TextEditingController();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  _CameraDetailPageState createState() => _CameraDetailPageState();
}

class _CameraDetailPageState extends State<CameraDetail> {
  dynamic cameraDetail;

  @override
  void initState() {
    super.initState();
    GetCameraDetail(widget.cameraId);
  }

  Future<dynamic> GetCameraDetail(String cameraId) async {
    var data = await CameraServices.getCameraById(cameraId);
    setState(() {
      if (data != null) {
        cameraDetail = data['data'];
        print(cameraDetail);
      }
    });
  }

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
              imagePath:
                  "https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/cameraImage%2F${cameraDetail['cameraImage']}?alt=media&token=1c9b7155-76c4-494f-be18-7129eb06e729",
              height: 250.v,
              width: 374.h,
              margin: EdgeInsets.only(left: 1.h),
            ),
            SizedBox(height: 2.v),
            Padding(
              padding: EdgeInsets.only(left: 9.h),
              child: Text(
                widget.cameraName,
                style: theme.textTheme.headlineLarge,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 9.h),
              child: Text(
                widget.cameraStatus,
                style: CustomTextStyles.titleSmallPop,
              ),
            ),
            SizedBox(height: 15.v),
            _title(context),
            SizedBox(height: 16.v),
            // _cameraList(context),
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
                    "Information",
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
                        "Camera Destination",
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        widget.cameraDestination,
                        style: theme.textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(height: 20.v),
                Padding(
                  padding: EdgeInsets.only(right: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Alarm Count",
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        cameraDetail['recordCount'].toString(),
                        style: theme.textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
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
                    return _buildCameraWidget(context, cameraName: "hi");
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

  Widget _buildCameraWidget(BuildContext context,
      {required String cameraName}) {
    return SizedBox(
      width: 106.h,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8.h,
            vertical: 6.v,
          ),
          decoration: AppDecoration.fillBlueGray
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomImageView(
                imagePath: ImageConstant.backGroungImage,
                height: 16.v,
                width: 17.h,
                margin: EdgeInsets.only(top: 42.v),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.h, top: 30.v),
                child: Text(
                  cameraName,
                  style: theme.textTheme.labelLarge,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
