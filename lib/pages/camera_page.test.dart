import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/camera_detail.test.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/camera_show.test.dart';
import 'package:facs_mobile/services/camera_services.dart';
import 'package:facs_mobile/themes/app_decoration.dart';
import 'package:facs_mobile/themes/custom_text_style.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_leading_image.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_title.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_trailing_image.dart';
import 'package:facs_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:facs_mobile/widgets/custom_bottom_bar.dart';
import 'package:facs_mobile/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class CamerasPage extends StatefulWidget {
  CamerasPage({Key? key})
      : super(
          key: key,
        );

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CamerasPage> {
  List<dynamic> cameraData = [];

  @override
  void initState() {
    super.initState();
    fetchCameraData();
  }

  Future<void> fetchCameraData() async {
    dynamic data = await CameraServices.getCamera();

    setState(() {
      cameraData = data != null ? data['data'] : [];
    });
    print(cameraData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: _buildAppbar(context),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Container(
              height: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  kBottomNavigationBarHeight -
                  33.v,
              child: Column(
                children: [
                  SizedBox(height: 30.v),
                  _buildUserProfile(context),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.h),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 145.v,
            mainAxisSpacing: 21.h,
            crossAxisSpacing: 21.h),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cameraData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to another page when tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CameraDetail(
                          cameraDestination: cameraData[index]
                              ['cameraDestination'],
                          cameraId: cameraData[index]['cameraId'],
                          cameraName: cameraData[index]['cameraName'],
                          cameraStatus: cameraData[index]['status'],
                        )),
              );
            },
            child: _buildCameraWidget(context,
                cameraName: cameraData[index]['cameraName'],
                cameraImage: cameraData[index]['cameraImage']),
          );
        },
      ),
    );
  }

  Widget _buildCameraWidget(BuildContext context,
      {required String cameraName, required String cameraImage}) {
    return Column(
      children: [
        Container(
          height: 104.v,
          width: 145.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/CameraImage%2F${cameraImage}?alt=media&token=b8d3c989-93d7-4af2-b437-1e85f8187577"),
              fit: BoxFit.cover,
            ),
          ),
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
                  cameraName,
                  style: CustomTextStyles.titleSmallOnPrimary,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imageCamera,
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

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
    );
  }
}
