import 'package:facs_mobile/app/utils/image_constant.dart';
import 'package:facs_mobile/app/utils/size_utils.dart';
import 'package:facs_mobile/services/camera_services.dart';
import 'package:facs_mobile/services/user_services.dart';
import 'package:facs_mobile/app/themes/app_decoration.dart';
import 'package:facs_mobile/app/themes/theme_helper.dart';
import 'package:facs_mobile/app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class FixCameraPage extends StatefulWidget {
  final String cameraId;
  final String cameraDestination;
  final String cameraName;
  FixCameraPage(
      {Key? key,
      required this.cameraId,
      required this.cameraDestination,
      required this.cameraName})
      : super(key: key);

  TextEditingController colortext = TextEditingController();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  _FixCameraPageState createState() => _FixCameraPageState();
}

class _FixCameraPageState extends State<FixCameraPage> {
  dynamic cameraDetail;

  @override
  void initState() {
    super.initState();
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
                    "https://media.tegna-media.com/assets/WPMT/images/dfa3ff26-69bb-4117-91d1-932671039b83/dfa3ff26-69bb-4117-91d1-932671039b83_1920x1080.jpg",
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
                  'Disconnected',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15.v),
              _title(context),
              SizedBox(height: 16.v),
              // _cameraList(context),
              SizedBox(height: 5.v),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: _buildButton(context)),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildButton(BuildContext context) {
    if (UserServices.userRole == 'Manager') {
      return ElevatedButton(
        onPressed: () async {
          try {
            bool fixed = await CameraServices.fixCamera(widget.cameraId);
            if (fixed) {
              Navigator.of(context).pop();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Camera has been fixed successfully')));
            } else {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to fix camera')));
            }
          } catch (e) {
            Navigator.of(context).pop();
            print('Error fixing camera: $e');
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to fix camera: $e')));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF006BD4),
          textStyle: TextStyle(color: Colors.white),
        ),
        child: Text(
          'Fix camera',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () async {
          if (await Permission.phone.request().isGranted) {
            _callEmergencyNumber();
          } else {
            // Permission is not granted, request it from the user
            await openAppSettings();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please grant phone permission to make a call.'),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFF3131),
          textStyle: TextStyle(color: Colors.white),
        ),
        child: Text(
          'Call admin',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void _callEmergencyNumber() async {
    dynamic url = Uri.parse('tel:0392658221');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
