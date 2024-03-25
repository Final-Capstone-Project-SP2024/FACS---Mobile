import 'package:flutter/material.dart';
import 'package:facs_mobile/services/camera_services.dart';
import 'package:facs_mobile/services/location_services.dart';

class AddCameraPage extends StatefulWidget {
  @override
  _AddCameraPageState createState() => _AddCameraPageState();
}

class _AddCameraPageState extends State<AddCameraPage> {
  late TextEditingController destinationController;
  late String selectedLocationId;
  List<dynamic> locations = [];

  @override
  void initState() {
    super.initState();
    destinationController = TextEditingController();
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    dynamic data = await LocationServices.getLocation();

    setState(() {
      locations = data != null ? data['data'] : [];
      selectedLocationId = locations.isNotEmpty ? locations[0]['id'] : '';
    });
  }

  Future<void> submitForm() async {
    String destination = destinationController.text;
    bool success = await CameraServices.addCamera(
      status: 'Active',
      destination: destination,
      locationId: selectedLocationId,
    );

    if (success) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Camera added successfully'),
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add camera'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Camera'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Camera Destination'),
            TextFormField(
              controller: destinationController,
              decoration: InputDecoration(
                hintText: 'Enter camera destination',
              ),
            ),
            SizedBox(height: 16),
            Text('Location'),
            DropdownButtonFormField(
              value: selectedLocationId,
              items: locations.map<DropdownMenuItem<String>>((location) {
                return DropdownMenuItem<String>(
                  value: location['id'],
                  child: Text(location['locationName']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedLocationId = value.toString();
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                submitForm();
              },
              child: Text('Add Camera'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    destinationController.dispose();
    super.dispose();
  }
}
