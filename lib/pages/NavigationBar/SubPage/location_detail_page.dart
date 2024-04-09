import 'package:flutter/material.dart';
import 'package:facs_mobile/services/location_services.dart';

class LocationDetail extends StatefulWidget {
  String locationId = "";
  LocationDetail({required this.locationId});

  @override
  _LocationDetailPageState createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetail> {
  dynamic locationDetailResponse;
  @override
  void initState() {
    super.initState();
    getLocationDetailById(widget.locationId);
  }

  Future<dynamic> getLocationDetailById(String locationId) async {
    var data = await LocationServices.getLocationDetail(locationId);
    setState(() {
      if (data != null) {
        locationDetailResponse = data['data'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final Map<String, dynamic> data = {
    //   "locationId": "1be53384-2d2e-48d3-bd0c-7171b6203f9c",
    //   "locationName": "Floor 1",
    //   "createdDate": "2024-03-13T08:44:33.643089",
    //   "users": [],
    //   "cameraInLocations": [
    //     "04b1ee5b-3a5c-4f25-9a91-dab71eb1b956",
    //     "ae345580-8276-4181-ba97-33f95df700f9"
    //   ]
    // };

    return Scaffold(
      appBar: AppBar(
        title: Text('Location Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location Name: ${locationDetailResponse['locationName']}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Location ID: ${locationDetailResponse['locationId']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Created Date: ${locationDetailResponse['createdDate']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Cameras in Location:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: locationDetailResponse['cameraInLocations'].length,
            //     itemBuilder: (context, index) {
            //       final cameraId =
            //           locationDetailResponse['cameraInLocations'][index];
            //       return Card(
            //         child: ListTile(
            //           title: Text(
            //             'Camera ID: $cameraId',
            //             style: TextStyle(fontSize: 16),
            //           ),
            //           // You can add more details here if needed
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
