import 'package:facs_mobile/pages/NavigationBar/SubPage/alarm_page.test.dart';
import 'package:facs_mobile/pages/camera_page.test.dart';
import 'package:facs_mobile/pages/location_list.test.dart';
import 'package:flutter/material.dart';
import 'package:facs_mobile/pages/NavigationBar/dashboard_page.dart';
import 'package:facs_mobile/pages/NavigationBar/camera_page.dart';
import 'package:facs_mobile/pages/NavigationBar/add_alarm_page.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _pages[_selectedIndex],
            Positioned(
              top: 5,
              left: 5,
              child: IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.pushNamed(context, "/profile");
                },
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.pushNamed(context, "/notification");
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add),
            label: 'Add Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Timeline',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.grey.shade100,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
