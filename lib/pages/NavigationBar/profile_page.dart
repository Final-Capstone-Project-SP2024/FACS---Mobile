import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(height: 50),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Edit Profile'),
                    onTap: () {
                      // Add edit profile logic here
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
                      //add sign out logic
                      Navigator.pushNamed(context, "/onboarding");
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
}
