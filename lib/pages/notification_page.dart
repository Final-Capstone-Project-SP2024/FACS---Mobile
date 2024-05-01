import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/fix_camera_page.dart';
import 'package:facs_mobile/pages/NavigationBar/camera_page.dart';
import 'package:facs_mobile/pages/camera_page.test.dart';
import 'package:facs_mobile/pages/record_detail_page.test.dart';
import 'package:facs_mobile/themes/app_decoration.dart';
import 'package:facs_mobile/themes/custom_text_style.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_leading_image.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_title.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_trailing_image.dart';
import 'package:facs_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:facs_mobile/widgets/custom_icon_button.dart';
import 'package:facs_mobile/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:facs_mobile/services/notification_services.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/record_detail_page.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> notificationData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNotificationData();
  }

  Future<void> fetchNotificationData() async {
    dynamic dataFetch = await NotificationService.getNotification();
    List<dynamic> fetchedNotifications = dataFetch['data'];
    fetchedNotifications.sort((a, b) {
      try {
        DateTime dateA =
            DateFormat('HH:mm:ss dd-MM-yyyy').parse(a['occurrenceTime']);
        DateTime dateB =
            DateFormat('HH:mm:ss dd-MM-yyyy').parse(b['occurrenceTime']);
        return dateB.compareTo(dateA);
      } catch (e) {
        print('Error parsing date: ${a['occurrenceTime']}');
        return 0;
      }
    });
    print(dataFetch);
    setState(() {
      notificationData = dataFetch != null ? dataFetch['data'] : [];
      isLoading = false;
    });
    print(notificationData);
  }

  String getImagePath(int status) {
    if (status == 1) {
      return ImageConstant.imageAlert;
    } else if (status == 2) {
      return ImageConstant.imageDisconnected;
    } else {
      return ImageConstant.imageAlarmByUser;
    }
  }

  // Define a function to determine the color based on status
  Color getStatusColor(String status) {
    if (status == 'InAlarm') {
      return Colors.orange[100]!;
    } else if (status == 'InVote') {
      return Colors.yellow[100]!;
    } else if (status == 'EndVote') {
      return Colors.amber[100]!;
    } else if (status == 'InAction') {
      return Colors.deepOrangeAccent[100]!;
    }
    return Colors.grey[100]!; // Default color
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: AppBar(
          title: Text('Warning'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            // Call the fetchNotificationData function when refreshing
            await fetchNotificationData();
          },
          child: SingleChildScrollView(
            physics:
                AlwaysScrollableScrollPhysics(), // Ensures the refresh indicator works
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 27.h,
                vertical: 29.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today",
                    style: theme.textTheme.titleSmall,
                  ),
                  SizedBox(height: 10.v),
                  _buildRowline(context),
                  SizedBox(height: 5.v),
                ],
              ),
            ),
          ),
        ),
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
        text: "Warning",
        margin: EdgeInsets.only(
          left: 32.h,
          top: 35.v,
          bottom: 10.v,
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgFilter,
          margin: EdgeInsets.fromLTRB(14.h, 34.v, 14.h, 12.v),
        )
      ],
    );
  }

  Widget _buildRowline(BuildContext context) {
    double verticalDividerHeight = notificationData.length *
        85.0; // Calculate the height of the vertical divider

    return Container(
      decoration: AppDecoration.outlineErrorContainer,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: verticalDividerHeight,
            width: 36.h,
            margin: EdgeInsets.only(
              top: 4.v,
              bottom: 44.v,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ...List.generate(
                  notificationData.length,
                  (index) {
                    return Positioned(
                      top: (index / notificationData.length) *
                          verticalDividerHeight,
                      child: Column(
                        children: [
                          CustomIconButton(
                            height: 36.adaptSize,
                            width: 36.adaptSize,
                            padding: EdgeInsets.all(5.h),
                            alignment: Alignment.topCenter,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Colors.grey.withOpacity(
                                    0.1), // Adjust the opacity or color here
                                BlendMode.srcATop,
                              ),
                              child: CustomImageView(
                                imagePath: getImagePath(
                                    notificationData[index]['recordType']),
                              ),
                            ),
                          ),
                          if (index < notificationData.length - 1)
                            SizedBox(
                              height: verticalDividerHeight /
                                  notificationData.length,
                              width: 4.h,
                              child: VerticalDivider(
                                thickness: 4.v,
                                color: appTheme.gray300,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 14.h,
                bottom: 9.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: notificationData.map<Widget>((data) {
                  return _buildRowtypesomethin(context,
                      cameraId: data['cameraId'],
                      cameraName: data['cameraName'],
                      cameraDestination: data['cameraName'],
                      recordId: data['recordId'],
                      time: data['occurrenceTime'],
                      status: data['status'],
                      location:
                          "${data['cameraDestination']}-${data['locationName']}",
                      imageOne: ImageConstant.imgRectangleCopy,
                      recordType: data['recordType'].toString());
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRowtypesomethin(
    BuildContext context, {
    required String cameraId,
    required String cameraName,
    required String cameraDestination,
    required String recordId,
    required String time,
    required String status,
    required String location,
    required String imageOne,
    required String recordType,
  }) {
    return GestureDetector(
      onTap: () {
        if (recordType == 2.toString()) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FixCameraPage(
                  cameraId: cameraId,
                  cameraName: cameraName,
                  cameraDestination: cameraDestination),
              // builder: (context) => CamerasPage(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecordDetailUserRoleEightScreen(
                recordId: recordId,
                state: status,
              ),
            ),
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: CustomTextStyles.titleMediumOnPrimary.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 4.v),
                Text(
                  status,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: getStatusColor(status),
                  ),
                ),
                SizedBox(height: 1.v),
                Text(
                  location,
                  style: CustomTextStyles.titleMediumBlueGray30001,
                ),
              ],
            ),
          ),
          CustomImageView(
            imagePath: imageOne,
            height: 16.adaptSize,
            width: 16.adaptSize,
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 7.h, bottom: 7.v),
          )
        ],
      ),
    );
  }
}
