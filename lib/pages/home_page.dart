import 'package:flutter/material.dart';
import 'package:facs_mobile/pages/NavigationBar/camera_page.dart';
import 'package:facs_mobile/pages/NavigationBar/dashboard_page.dart';
import 'package:facs_mobile/pages/NavigationBar/profile_page.dart';
import 'package:facs_mobile/pages/NavigationBar/timeline_page.dart';

class HomePage extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    DashboardPage(),
    CameraPage(),
    TimelinePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _pages[_selectedIndex],
            Positioned(
              top: 0,
              left: 0,
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
            icon: Icon(Icons.timeline),
            label: 'Timeline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
