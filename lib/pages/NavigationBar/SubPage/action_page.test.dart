import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/listdynamic_item_widget.test.dart';
import 'package:facs_mobile/pages/home_page.dart';
import 'package:facs_mobile/services/record_service.dart';
import 'package:facs_mobile/themes/app_decoration.dart';
import 'package:facs_mobile/themes/custom_bottom_style.dart';
import 'package:facs_mobile/themes/custom_text_style.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_leading_image.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_title.dart';
import 'package:facs_mobile/widgets/app_bar/appbar_trailing_image.dart';
import 'package:facs_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:facs_mobile/widgets/custom_evulated_bottom.test.dart';
import 'package:facs_mobile/widgets/custom_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlarmPage extends StatefulWidget {
  final String recordId;
  const AlarmPage({super.key, required this.recordId});

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  int _selectedLevel = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: AppBar(
          title: Text(''),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        // appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 18.v,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 26.v,
              ),
              Text(
                "Choose alarm Level ?",
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 13.v,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Action Alarm",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: 13.v,
              ),
              _chooseList(context),
              Spacer(),
              _confirmButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chooseList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.h),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 4.v,
          );
        },
        itemCount: 5,
        itemBuilder: (context, index) {
          return buildAlarmLevelWidget(context, index);
        },
      ),
    );
  }

  Widget buildAlarmLevelWidget(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLevel = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 11.v),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: _selectedLevel == index ? Colors.orange : Colors.black,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.v, bottom: 3.v),
              child: Text(
                "Alarm Level ${index + 1}",
                style: TextStyle(
                  color: _selectedLevel == index
                      ? Colors.orange
                      : theme.colorScheme.onPrimary,
                  fontSize: 16.adaptSize,
                  fontWeight: _selectedLevel == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            if (_selectedLevel == index)
              Container(
                margin: EdgeInsets.only(top: 14.v, right: 14.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: Icon(
                  Icons.check,
                  size: 18.adaptSize,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _confirmButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 11.h, right: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomEvulatedBottom(
              onPressed: () {
                // Add your code to use _selectedLevel here
                _selectedLevel++;
                print("Selected alarm level: $_selectedLevel");
                RecordService.actionAlarm(
                    recordId: widget.recordId, alarmLevel: _selectedLevel);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Action Alarm Successfully')),
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
}
