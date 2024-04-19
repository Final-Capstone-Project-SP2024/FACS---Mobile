import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/camera_detail.test.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/camera_show.test.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_leading_image.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_title.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_trailing_image.dart';
import 'package:facs_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:facs_mobile/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

class CamerasPage extends StatelessWidget {
  CamerasPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppbar(context),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            SizedBox(
              height: 33.v,
            ),
            _buildUserProfile(context),
            Spacer()
          ],
        ),
      ),
    ));
  }
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
      itemCount: 6,
      itemBuilder: (context, indext) {
        return GestureDetector(
          onTap: () {
            // Navigate to another page when tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraDetail()),
            );
          },
          child: const CameraList(),
        );
      },
    ),
  );
}

PreferredSizeWidget _buildAppbar(BuildContext context) {
  return CustomAppBar(
    leadingWidth: 40.h,
  );
}
