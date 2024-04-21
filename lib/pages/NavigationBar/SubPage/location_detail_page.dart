import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/themes/app_decoration.dart';
import 'package:facs_mobile/themes/custom_text_style.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:facs_mobile/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:facs_mobile/services/location_services.dart';

class LocationDetail extends StatefulWidget {
  String locationId = "";
  LocationDetail({required this.locationId});

  @override
  _LocationDetailPageState createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetail> {
  dynamic locationDetailResponse;
  @override
  void initState() {
    super.initState();
    getLocationDetailById(widget.locationId);
  }

  Future<dynamic> getLocationDetailById(String locationId) async {
    var data = await LocationServices.getLocationDetail(locationId);
    setState(() {
      if (data != null) {
        locationDetailResponse = data['data'];
      }
    });
    print(locationDetailResponse);
    print(data);
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
              imagePath: ImageConstant.imageLocation,
              height: 250.v,
              width: 374.h,
              margin: EdgeInsets.only(left: 1.h),
            ),
            SizedBox(height: 2.v),
            Padding(
              padding: EdgeInsets.only(left: 9.h),
              child: Text(
                locationDetailResponse['locationName'],
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
            SizedBox(height: 15.v),
            _dataInLocation(context),
            SizedBox(height: 16.v),
            _cameraList(context),
            SizedBox(height: 5.v)
          ],
        ),
      ),
    ));
  }

  Widget _dataInLocation(BuildContext context) {
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
                        locationDetailResponse['numberOfCamera'].toString(),
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
                        "Users",
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        locationDetailResponse['numberOfSecurity'].toString(),
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
                imagePath: ImageConstant.imgCameraOnprimary,
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
