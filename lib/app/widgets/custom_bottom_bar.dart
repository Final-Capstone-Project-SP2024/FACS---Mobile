import 'package:facs_mobile/app/utils/image_constant.dart';
import 'package:facs_mobile/app/utils/size_utils.dart';
import 'package:facs_mobile/app/themes/theme_helper.dart';
import 'package:facs_mobile/app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

enum BottomBarEnum { Warning, Colorblack, Clock, Lock }
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgWarning,
      activeIcon: ImageConstant.imgWarning,
      type: BottomBarEnum.Warning,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgColorBlack,
      activeIcon: ImageConstant.imgColorBlack,
      type: BottomBarEnum.Colorblack,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgClock,
      activeIcon: ImageConstant.imgClock,
      type: BottomBarEnum.Clock,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgLock,
      activeIcon: ImageConstant.imgLock,
      type: BottomBarEnum.Lock,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Divider(),
        ),
        SizedBox(
          height: 80.v,
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0,
            elevation: 0,
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.fixed,
            items: List.generate(bottomMenuList.length, (index) {
              return BottomNavigationBarItem(
                icon: SizedBox(
                  height: 32.v,
                  width: 29.h,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CustomImageView(
                        imagePath: bottomMenuList[index].icon,
                        height: 32.v,
                        width: 29.h,
                        color: theme.colorScheme.onError,
                        alignment: Alignment.center,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 13.adaptSize,
                          width: 13.adaptSize,
                          margin: EdgeInsets.only(
                            left: 16.h,
                            top: 1.v,
                            bottom: 17.v,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(
                              6.h,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                activeIcon: CustomImageView(
                  imagePath: bottomMenuList[index].activeIcon,
                  height: 32.adaptSize,
                  width: 32.adaptSize,
                  color: theme.colorScheme.primary,
                ),
                label: '',
              );
            }),
            onTap: (index) {
              selectedIndex = index;
              widget.onChanged?.call(bottomMenuList[index].type);
              setState(() {});
            },
          ),
        )
      ],
    );
  }
}
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class BottomMenuModel {
  BottomMenuModel(
      {required this.icon, required this.activeIcon, required this.type});

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
