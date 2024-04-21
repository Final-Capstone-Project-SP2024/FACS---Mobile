// import 'package:facs_mobile/core/utils/image_constant.dart';
// import 'package:facs_mobile/core/utils/size_utils.dart';
// import 'package:facs_mobile/pages/record_detail_page.test.dart';
// import 'package:facs_mobile/themes/app_decoration.dart';
// import 'package:facs_mobile/themes/custom_text_style.dart';
// import 'package:facs_mobile/themes/theme_helper.dart';
// import 'package:facs_mobile/widgets/custom_image_view.dart';
// import 'package:flutter/material.dart';
// import '../../core/app_export.dart';
// import '../../widgets/app_bar/appbar_leading_image.dart';
// import '../../widgets/app_bar/appbar_title.dart';
// import '../../widgets/app_bar/appbar_trailing_image.dart';
// import '../../widgets/app_bar/custom_app_bar.dart';
// import '../../widgets/custom_icon_button.dart'; // ignore_for_file: must_be_immutable

// class NotificationPageTest extends StatelessWidget {
//   const NotificationPageTest({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: appTheme.whiteA700,
//         appBar: _buildAppbar(context),
//         body: Container(
//           width: double.maxFinite,
//           padding: EdgeInsets.symmetric(
//             horizontal: 27.h,
//             vertical: 29.v,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "YesterDay",
//                 style: theme.textTheme.titleSmall,
//               ),
//               SizedBox(height: 10.v),
//               _buildRowline(context,
//                   destination: "Location A",
//                   time: "12/02/2002",
//                   typeWarning: "In Alarm"),
//               SizedBox(height: 5.v),
//               _buildRowline(context,
//                   destination: "Location A",
//                   time: "12/02/2002",
//                   typeWarning: "In Alarm"),
//               SizedBox(height: 5.v)
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   PreferredSizeWidget _buildAppbar(BuildContext context) {
//     return CustomAppBar(
//       leadingWidth: 40.h,
//       leading: AppbarLeadingImage(
//         imagePath: ImageConstant.imgArrowDown,
//         margin: EdgeInsets.only(
//           left: 16.h,
//           top: 34.v,
//           bottom: 12.v,
//         ),
//       ),
//       title: AppbarTitle(
//         text: "Warning",
//         margin: EdgeInsets.only(
//           left: 32.h,
//           top: 35.v,
//           bottom: 10.v,
//         ),
//       ),
//       actions: [
//         AppbarTrailingImage(
//           imagePath: ImageConstant.imgFilter,
//           margin: EdgeInsets.fromLTRB(14.h, 34.v, 14.h, 12.v),
//         )
//       ],
//     );
//   }

//   /// Section Widget
//   Widget _buildRowline(BuildContext context,
//       {required String time,
//       required String typeWarning,
//       required String destination}) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 248.v,
//           width: 36.h,
//           margin: EdgeInsets.only(
//             top: 4.v,
//             bottom: 44.v,
//           ),
//           child: Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: SizedBox(
//                   height: 118.v,
//                   child: VerticalDivider(
//                     width: 4.h,
//                     thickness: 4.v,
//                     color: appTheme.gray300,
//                     indent: 18.h,
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: SizedBox(
//                   height: 130.v,
//                   child: VerticalDivider(
//                     width: 4.h,
//                     thickness: 4.v,
//                     color: appTheme.gray300,
//                     endIndent: 30.h,
//                   ),
//                 ),
//               ),
//               CustomIconButton(
//                 height: 36.adaptSize,
//                 width: 36.adaptSize,
//                 padding: EdgeInsets.all(5.h),
//                 alignment: Alignment.topCenter,
//                 child: CustomImageView(
//                   imagePath: ImageConstant.imgGroup94,
//                 ),
//               ),
//               CustomIconButton(
//                 height: 36.adaptSize,
//                 width: 36.adaptSize,
//                 padding: EdgeInsets.all(5.h),
//                 alignment: Alignment.center,
//                 child: CustomImageView(
//                   imagePath: ImageConstant.imgGroup94,
//                 ),
//               ),
//               CustomIconButton(
//                 height: 36.adaptSize,
//                 width: 36.adaptSize,
//                 padding: EdgeInsets.all(5.h),
//                 alignment: Alignment.bottomCenter,
//                 child: CustomImageView(
//                   imagePath: ImageConstant.imgGroup94,
//                 ),
//               )
//             ],
//           ),
//         ),
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: 14.h,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   time,
//                   style: CustomTextStyles.titleMediumOnPrimary,
//                 ),
//                 SizedBox(height: 4.v),
//                 Text(
//                   typeWarning,
//                   style: theme.textTheme.titleMedium,
//                 ),
//                 SizedBox(height: 1.v),
//                 Text(
//                   destination,
//                   style: CustomTextStyles.titleLargeBluegray300,
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   /// Common widget
//   /// Common widget
//   Widget _buildRowtypesomethin(
//     BuildContext context, {
//     required String time,
//     required String typesomething,
//     required String typesomething1,
//     required String imageOne,
//     required VoidCallback onPressed, // Add this line
//   }) {
//     return GestureDetector(
//       // Wrap with GestureDetector
//       onTap: () {
//         // Navigate to the desired page
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 RecordDetailUserRoleEightScreen(), // Replace YourDestinationPage with the page you want to navigate to
//           ),
//         );
//       }, // Set the onPressed callback
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(bottom: 11.v),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   time,
//                   style: CustomTextStyles.titleMediumOnPrimary.copyWith(
//                     color: theme.colorScheme.onPrimary,
//                   ),
//                 ),
//                 SizedBox(height: 4.v),
//                 Text(
//                   typesomething,
//                   style: theme.textTheme.titleMedium!.copyWith(
//                     color: appTheme.blueGray300,
//                   ),
//                 ),
//                 SizedBox(height: 1.v),
//                 Text(
//                   typesomething1,
//                   style: theme.textTheme.titleMedium!.copyWith(
//                     color: appTheme.blueGray300,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           CustomImageView(
//             imagePath: imageOne,
//             height: 70.v,
//             width: 100.h,
//             radius: BorderRadius.circular(
//               4.h,
//             ),
//             margin: EdgeInsets.only(top: 4.v),
//           )
//         ],
//       ),
//     );
//   }
// }
