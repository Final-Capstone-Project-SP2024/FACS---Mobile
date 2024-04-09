import 'package:flutter/material.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/update_profile_page.dart';
import 'package:facs_mobile/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userFullname = '';

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  Future<void> loadUserDetails() async {
    try {
      final userDetails = await UserServices().getUserDetails(UserServices.userId);
      if (userDetails.containsKey('data')) {
        final userData = userDetails['data'];
        final name = userData['name'];
        setState(() {
          userFullname = name;
        });
      } else {
        throw Exception('User data not found in response');
      }
    } catch (e) {
      print('Error loading user details: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(height: 20),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'lib/assets/images/profile_image.png',
                      width: 96,
                      height: 96,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  userFullname,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Edit Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProfilePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('FAQ'),
                    onTap: () {
                      // Add FAQ logic here
                    },
                  ),
                  ListTile(
                    title: Text('Sign Out'),
                    onTap: () {
                      clearCredentials(context);
                      Navigator.pushNamed(context, "/signin");
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> clearCredentials(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('securityCode');
    await prefs.remove('password');
  }
}
