import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
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
    setState(() {
      notificationData = dataFetch != null ? dataFetch['data'] : [];
      isLoading = false;
    });
    print(notificationData);
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Fire Alarm Notifications'),
  //       backgroundColor: Colors.red, // Set app bar color to red
  //     ),
  //     body: isLoading
  //         ? Center(
  //             child: CircularProgressIndicator(),
  //           )
  //         : notificationData.isNotEmpty
  //             ? ListView.builder(
  //                 itemCount: notificationData.length,
  //                 itemBuilder: (context, index) {
  //                   return GestureDetector(
  //                     onTap: () {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => RecordDetail(
  //                             recordId: notificationData[index]['recordId'],
  //                             state: notificationData[index]['status'],
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                     child: Card(
  //                       elevation: 4,
  //                       margin:
  //                           EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                       color:
  //                           getStatusColor(notificationData[index]['status']),
  //                       child: ListTile(
  //                         contentPadding:
  //                             EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //                         title: Text(
  //                           notificationData[index]['locationName'],
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.red, // Set text color to red
  //                           ),
  //                         ),
  //                         subtitle: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             SizedBox(height: 4),
  //                             Text(
  //                               'Camera: ${notificationData[index]['cameraName']}',
  //                               style: TextStyle(fontWeight: FontWeight.bold),
  //                             ),
  //                             SizedBox(height: 4),
  //                             Text(
  //                               'Location: ${notificationData[index]['cameraDestination']}',
  //                             ),
  //                             SizedBox(height: 4),
  //                             Text(
  //                               'Status: ${notificationData[index]['status']}',
  //                             )
  //                           ],
  //                         ),
  //                         trailing: Icon(
  //                           Icons.fire_extinguisher, // Fire icon
  //                           color: Colors.red, // Set icon color to red
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               )
  //             : Center(
  //                 child: Text('No notifications available'),
  //               ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: _buildAppbar(context),
        body: Container(
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
              SizedBox(height: 5.v)
            ],
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

  /// Section Widget
  Widget _buildRowline(BuildContext context) {
    return Container(
      decoration: AppDecoration.outlineErrorContainer,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 248.v,
            width: 36.h,
            margin: EdgeInsets.only(
              top: 4.v,
              bottom: 44.v,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 118.v,
                    child: VerticalDivider(
                      width: 4.h,
                      thickness: 4.v,
                      color: appTheme.gray300,
                      indent: 18.h,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 130.v,
                    child: VerticalDivider(
                      width: 4.h,
                      thickness: 4.v,
                      color: appTheme.gray300,
                      endIndent: 30.h,
                    ),
                  ),
                ),
                CustomIconButton(
                  height: 36.adaptSize,
                  width: 36.adaptSize,
                  padding: EdgeInsets.all(5.h),
                  alignment: Alignment.topCenter,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgGroup94,
                  ),
                ),
                CustomIconButton(
                  height: 36.adaptSize,
                  width: 36.adaptSize,
                  padding: EdgeInsets.all(5.h),
                  alignment: Alignment.center,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgGroup94,
                  ),
                ),
                CustomIconButton(
                  height: 36.adaptSize,
                  width: 36.adaptSize,
                  padding: EdgeInsets.all(5.h),
                  alignment: Alignment.bottomCenter,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgGroup94,
                  ),
                )
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
                children: [
                  Text(
                    "12:00",
                    style: CustomTextStyles.titleMediumOnPrimary,
                  ),
                  SizedBox(height: 4.v),
                  Text(
                    "Warning Fire",
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 1.v),
                  SizedBox(
                    height: 19.v,
                    width: 142.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Camera Destination",
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Camera Destination",
                            style: theme.textTheme.titleMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 42.v),
                  _buildRowtypesomethin(
                    context,
                    time: "11:00",
                    typesomething: "Warning Small Fire",
                    typesomething1: "Camera Destination",
                    imageOne: ImageConstant.imgRectangleCopy,
                  ),
                  SizedBox(height: 33.v),
                  _buildRowtypesomethin(
                    context,
                    time: "10:00",
                    typesomething: "Warning Fire",
                    typesomething1: "Camera Destination",
                    imageOne: ImageConstant.imgRectangleCopy2,
                  )
                ],
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
    required String time,
    required String typesomething,
    required String typesomething1,
    required String imageOne,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 11.v),
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
                typesomething,
                style: theme.textTheme.titleMedium!.copyWith(
                  color: appTheme.blueGray300,
                ),
              ),
              SizedBox(height: 1.v),
              Text(
                typesomething1,
                style: theme.textTheme.titleMedium!.copyWith(
                  color: appTheme.blueGray300,
                ),
              )
            ],
          ),
        ),
        CustomImageView(
          imagePath: imageOne,
          height: 70.v,
          width: 100.h,
          radius: BorderRadius.circular(
            4.h,
          ),
          margin: EdgeInsets.only(top: 4.v),
        )
      ],
    );
  }
}
