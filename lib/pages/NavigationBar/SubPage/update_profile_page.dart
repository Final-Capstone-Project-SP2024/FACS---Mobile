import 'package:flutter/material.dart';
import 'package:facs_mobile/services/user_services.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState(){
    super.initState();
    loadUserDetails();
  }
  Future<void> loadUserDetails() async {
    try {
      final userDetails = await UserServices().getUserDetails(UserServices.userId);
      if (userDetails.containsKey('data')) {
        final userData = userDetails['data'];
        setState(() {
          emailController.text = userData['email'];
          phoneController.text = userData['phone'];
          nameController.text = userData['name'];
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
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text.trim();
                String phone = phoneController.text.trim();
                String name = nameController.text.trim();

                bool success = await UserServices.updateUserProfile(
                  email: email,
                  phone: phone,
                  name: name,
                );

                if (success) {
                  // Profile updated successfully
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile updated successfully')),
                  );
                } else {
                  // Failed to update profile
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update profile')),
                  );
                }
              },
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
