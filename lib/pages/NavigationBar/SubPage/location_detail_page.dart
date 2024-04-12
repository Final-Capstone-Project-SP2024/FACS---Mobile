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
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: locationDetailResponse != null
            ? Column(
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
                  // Add code here to display cameras in location
                  // Add code here to display cameras in location
                  Expanded(
                    child: ListView.builder(
                      itemCount: locationDetailResponse['cameraInLocations'].length,
                      itemBuilder: (context, index) {
                        var camera = locationDetailResponse['cameraInLocations'][index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Camera Name: ${camera['cameraName']}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Camera Destination: ${camera['cameraDestination']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ),

                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
