import 'package:facs_mobile/core/utils/image_constant.dart';
import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/camera_detail.test.dart';
import 'package:facs_mobile/services/camera_services.dart';
import 'package:facs_mobile/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class CamerasPage extends StatefulWidget {
  CamerasPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CamerasPage> {
  List<dynamic> cameraData = [];

  @override
  void initState() {
    super.initState();
    fetchCameraData();
  }

  Future<void> fetchCameraData() async {
    dynamic data = await CameraServices.getCamera();

    setState(() {
      cameraData = data != null ? data['data'] : [];
    });
    print(cameraData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: fetchCameraData,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    _buildUserProfile(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 145,
        mainAxisSpacing: 21,
        crossAxisSpacing: 21,
      ),
      itemCount: cameraData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigate to another page when tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraDetail(
                  cameraDestination: cameraData[index]['cameraDestination'],
                  cameraId: cameraData[index]['cameraId'],
                  cameraName: cameraData[index]['cameraName'],
                  cameraStatus: cameraData[index]['status'],
                  cameraImage: cameraData[index]['cameraImage'],
                ),
              ),
            );
          },
          child: _buildCameraWidget(
            context,
            cameraName: cameraData[index]['cameraName'],
            cameraImage: cameraData[index]['cameraImage'],
            status: cameraData[index]['status'],
          ),
        );
      },
    );
  }

  Widget _buildCameraWidget(BuildContext context,
      {required String cameraName,
      required String cameraImage,
      required String status}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 104,
          //temp, make image in
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: Center(child: switchImage(status, cameraImage)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 7),
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                cameraName,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget switchImage(String status, String cameraImage) {
    if (status == 'Disconnected')
      return Center(
        child: CustomImageView(
          imagePath: ImageConstant.imgNoPhotography,
        ),
      );
    else
      return CustomImageView(
        imagePath:
            "https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/cameraImage%2F${cameraImage}?alt=media&token=1c9b7155-76c4-494f-be18-7129eb06e729",
      );
  }
}
