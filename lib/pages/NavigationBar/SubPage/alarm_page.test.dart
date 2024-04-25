import 'package:facs_mobile/services/camera_services.dart';
import 'package:facs_mobile/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/themes/app_decoration.dart';
import 'package:facs_mobile/themes/custom_text_style.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
// import 'package:facs_mobile/widgets/app_bar/appbar_leading_image.dart';
// import 'package:facs_mobile/widgets/app_bar/appbar_title.dart';
// import 'package:facs_mobile/widgets/app_bar/appbar_trailing_image.dart';
// import 'package:facs_mobile/widgets/app_bar/custom_app_bar.dart';
// import 'package:facs_mobile/widgets/custom_evulated_bottom.test.dart';
import 'package:facs_mobile/widgets/custom_image_view.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;

class AlarmByHandPage extends StatefulWidget {
  AlarmByHandPage({Key? key}) : super(key: key);

  @override
  _AlarmByHandPageState createState() => _AlarmByHandPageState();
}

class _AlarmByHandPageState extends State<AlarmByHandPage> {
  String? _selectedLocation;
  List<Map<String, String>> _locations = [];
  String? _selectedCamera;
  List<Map<String, String>> _cameras = [];
  Future<void> _fetchLocations() async {
    try {
      final response = await LocationServices.getLocation();
      if (response != null) {
        if (response.containsKey('data')) {
          List<dynamic> data = response['data'];
          List<Map<String, String>> locations = [];
          for (var locationData in data) {
            String locationId = locationData['locationId'];
            String locationName = locationData['locationName'];
            locations
                .add({'locationId': locationId, 'locationName': locationName});
          }
          setState(() {
            _locations = locations;
          });
        }
      }
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  Future<void> _fetchCameras(String locationId) async {
    try {
      final response = await LocationServices.getLocationDetail(locationId);
      if (response != null && response.containsKey('data')) {
        List<dynamic> cameraData = response['data']['cameraInLocations'];
        List<Map<String, String>> cameras = [];
        for (var camera in cameraData) {
          String cameraId = camera['cameraId'];
          String cameraName =
              '${camera['cameraName']} - ${camera['cameraDestination']}';
          cameras.add({'cameraId': cameraId, 'cameraName': cameraName});
        }
        setState(() {
          _cameras = cameras;
          if (_cameras.isNotEmpty) {
            _selectedCamera = _cameras.first['cameraId'];
          }
        });
      }
    } catch (e) {
      print('Error fetching cameras: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            CustomImageView(
              alignment: Alignment.center,
              imagePath: ImageConstant.backGroungImage,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 37.h, top: 46.v, right: 27.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 64.h, vertical: 48.v),
                      decoration: AppDecoration.outlineErrorContainer.copyWith(
                        image: DecorationImage(
                          image: fs.Svg(ImageConstant.circle),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.alarm,
                            height: 121.v,
                            width: 125.v,
                          ),
                          Text(
                            "Fire Alarm ",
                            style: theme.textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30.v),
                    _buildColumnDescription(context),
                    SizedBox(height: 25.v),
                    ElevatedButton(
                      onPressed: () {
                        _showEmergencyModal(context);
                      },
                      child: Text(
                        "EMERGENCY",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 49, 49),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showEmergencyModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildEmergencyModalContent(context),
    );
  }

  Widget _buildEmergencyModalContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Caution: Emergency Button Clicked!\n\nThis action initiates emergency procedures. Are you sure you want to proceed? Clicking this button will trigger urgent protocols and may result in immediate actions being taken. Please ensure that this action is absolutely necessary and deliberate. If you're uncertain, reconsider before proceeding.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select Location',
              border: OutlineInputBorder(),
            ),
            value: _selectedLocation,
            items: _locations.map((location) {
              return DropdownMenuItem<String>(
                value: location['locationId'],
                child: Text(location['locationName']!),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedLocation = value;
                _fetchCameras(value!);
              });
            },
          ),
          SizedBox(height: 20.0),
          if (_cameras.isNotEmpty) ...[
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Camera',
                border: OutlineInputBorder(),
              ),
              value: _selectedCamera,
              items: _cameras.map((camera) {
                return DropdownMenuItem<String>(
                  value: camera['cameraId'],
                  child: Text(camera['cameraName']!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCamera = value;
                });
              },
            ),
          ],
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              if (_selectedCamera != null) {
                try {
                  bool success = await CameraServices.alert(_selectedCamera!);
                  if (success) {
                    Navigator.pop(context); // Close the modal
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Alert sent successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to send alert.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No camera selected.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text('Submit'),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget _buildColumnDescription(BuildContext context) {
    return Container(
      width: 311.h,
      padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 36.v),
      decoration: AppDecoration.fillGrayDecor,
      child: Container(
        width: 297.h,
        margin: EdgeInsets.only(right: 5.h),
        child: Text(
          "When a fire appears, try your best to\nremain composed and hit the \n\"Emergency\" \nbutton right away to warn anyone nearby.",
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: CustomTextStyles.titleAlarm,
        ),
      ),
    );
  }
}
