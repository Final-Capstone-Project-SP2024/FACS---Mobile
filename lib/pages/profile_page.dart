import 'package:facs_mobile/pages/NavigationBar/SubPage/respond_guide_page.dart';
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
      final userDetails =
          await UserServices().getUserDetails(UserServices.userId);
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
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading:
            true, // Back button will be automatically added
      ),
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
                    leading: Icon(Icons.edit),
                    title: Text('Edit Profile',
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                    leading: Icon(Icons.help),
                    title: Text('Emergency Response Guide',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RespondGuidePage(),
                        ),
                      );
                    },
                  ),
                  // ListTile(
                  //   leading: Icon(Icons.bug_report),
                  //   title: Text('Bugs report', style: TextStyle(fontWeight: FontWeight.bold)),
                  //   onTap: () {
                  //     // Add bugs report logic here
                  //   },
                  // ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Sign Out',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onTap: () {
                      showConfirmationDialog(context);
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
    await prefs.setString('fcmToken', '0');
    UserServices.sendFCMToken();
    await prefs.remove('fcmToken');
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Sign Out"),
          content: Text("Are you sure you want to sign out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                clearCredentials(context);
                Navigator.pushNamed(context, "/signin");
              },
              child: Text("Sign Out"),
            ),
          ],
        );
      },
    );
  }
}
