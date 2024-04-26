import 'package:facs_mobile/pages/NavigationBar/SubPage/alarm_page.test.dart';
import 'package:facs_mobile/pages/camera_page.test.dart';
import 'package:facs_mobile/pages/location_list.test.dart';
import 'package:facs_mobile/pages/notification_page.dart';
import 'package:facs_mobile/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:facs_mobile/pages/NavigationBar/add_alarm_page.dart';
import 'package:facs_mobile/pages/NavigationBar/camera_page.dart';
import 'package:facs_mobile/pages/NavigationBar/dashboard_page.dart';
import 'package:facs_mobile/pages/NavigationBar/location_page.dart';
import 'package:facs_mobile/pages/NavigationBar/timeline_page.dart';

class HomePage extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    DashboardPage(),
    CamerasPage(),
    AlarmByHandPage(),
    LocationListShow(),
    TimelinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [
        const DashboardPage(),
        const CameraPage(),
        const AddAlarmPage(),
        const LocationPage(),
        const TimelinePage()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.dashboard),
          title: ("Home"),
          activeColorPrimary: Color.fromARGB(255, 0, 107, 212),
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.camera),
          title: ("Camera"),
          activeColorPrimary: Color.fromARGB(255, 0, 107, 212),
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.notification_add,
            color: Color.fromARGB(255, 0, 107, 212),
          ),
          inactiveIcon: const Icon(
            Icons.notification_add_outlined,
            color: Colors.white,
          ),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.location_city),
          title: ("Location"),
          activeColorPrimary: Color.fromARGB(255, 0, 107, 212),
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.timeline),
          title: ("Timeline"),
          activeColorPrimary: Color.fromARGB(255, 0, 107, 212),
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(context,
                    screen: ProfilePage(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino);
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                //Navigator.pushNamed(context, "/notification" );
                PersistentNavBarNavigator.pushNewScreen(context,
                    screen: NotificationPage(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino);
              },
            ),
          ],
        ),
      ),
      body: PersistentTabView(
        context,
        screens: _buildScreens(),
        items: _navBarsItems(),
        controller: controller,
        confineInSafeArea: true,
        backgroundColor: Colors.grey.shade100,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,
      ),
    );
  }
}
