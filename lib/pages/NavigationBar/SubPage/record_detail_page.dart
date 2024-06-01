import 'package:facs_mobile/core/utils/size_utils.dart';
import 'package:facs_mobile/services/record_service.dart';
import 'package:facs_mobile/themes/app_decoration.dart';
import 'package:facs_mobile/themes/custom_text_style.dart';
import 'package:facs_mobile/themes/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class RecordDetailPage extends StatefulWidget {
  final String recordId;
  final String state;

  const RecordDetailPage(
      {super.key, required this.recordId, required this.state});

  @override
  _RecordDetailPageState createState() => _RecordDetailPageState();
}

class _RecordDetailPageState extends State<RecordDetailPage> {
  dynamic recordDetailResponse;
  bool _showVideo = false;
  late VideoPlayerController _videoController;
  TextEditingController locationController = TextEditingController();
  TextEditingController colortexboxoneController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getRecordDetailId(widget.recordId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Column(
                    children: [
                      _showVideo
                          ? _showVideoWidget(context)
                          : _showImage(context),
                      SizedBox(height: 1.v),
                      _buildRowcameraone(context),
                      SizedBox(height: 5.v),
                      _buildUiboxmini(context),
                      SizedBox(height: 10.v),
                      Padding(
                        padding: EdgeInsets.only(left: 15.h),
                        child: Column(
                          children: [
                            _buildColumntypesomet(context),
                            SizedBox(height: 21.v),
                            _buildColumntypesomet1(context),
                            SizedBox(height: 20.v),
                            if (recordDetailResponse['userVoting'].isNotEmpty)
                              _buildActionFunction(context),
                            SizedBox(height: 20.v),
                            _buildUserResponsibility(context),
                            SizedBox(height: 10.v),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.v),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  void _initializeVideoController() {
    _videoController = VideoPlayerController.network(
        "https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/VideoRecord%2F${recordDetailResponse['videoRecord']['videoUrl']}?alt=media&token=18e13091-0a41-4b0e-9b9c-283fb2f3a803")
      ..initialize().then((_) {
        setState(() {});
      });
  }

  Future<dynamic> getRecordDetailId(String recordId) async {
    print(recordId);
    var data = await RecordService.getRecordDetail(recordId);
    setState(() {
      if (data != null) {
        recordDetailResponse = data['data'];

        print(recordDetailResponse);
        _initializeVideoController();
      }
    });
  }

  Widget _buildActionFunction(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Action",
              style: CustomTextStyles.titleLargeBluegray300,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recordDetailResponse['userVoting'].length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 15.h,
                  right: 31.h,
                ),
                child: _buildColorwhite(
                  context,
                  typesomething: recordDetailResponse['userVoting'][index]
                      ['securityCode'],
                  typesomething1: recordDetailResponse['userVoting'][index]
                      ['voteType'],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _showVideoWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.h,
        vertical: 14.v,
      ),
      decoration: AppDecoration.fillBlueGray,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_videoController.value.isPlaying) {
                    _videoController.pause();
                  } else {
                    _videoController.play();
                  }
                });
              },
              child: Container(
                color: Colors.black,
                child: _videoController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController),
                      )
                    : Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.h,
        vertical: 14.v,
      ),
      decoration: AppDecoration.fillBlueGray,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Add your code to navigate to another page here
              },
              child: Container(
                color: Colors.black,
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/ImageRecord%2F${recordDetailResponse['imageRecord']['imageUrl']}?alt=media&token=7b30179f-3ec9-4e33-956d-7ad737aeb82f',
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: 200, // Maximum input size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowcameraone(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.fillGray,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.v),
              child: Text(
                "Media Record",
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUiboxmini(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 17.h,
        vertical: 2.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.h,
              top: 2.v,
              bottom: 2.v,
            ),
            child: Text(
              recordDetailResponse['status'],
              style: theme.textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.v),
            child: Text(
              recordDetailResponse['recordTime'],
              style: theme.textTheme.titleMedium,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildColumntypesomet(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 24.v,
              width: 90.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Camera",
                      style: CustomTextStyles.titleLargeBluegray300,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Camera",
                      style: CustomTextStyles.titleLargeBluegray300,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 4.v),
          Padding(
            padding: EdgeInsets.only(
              left: 18.h,
              right: 32.h,
            ),
            child: _buildColorwhite(
              context,
              typesomething: "Location",
              typesomething1: "Location A",
            ),
          ),
          SizedBox(height: 1.v),
          Padding(
            padding: EdgeInsets.only(
              left: 18.h,
              right: 32.h,
            ),
            child: _buildColorwhite(
              context,
              typesomething: "Camera Name",
              typesomething1: recordDetailResponse['cameraName'],
            ),
          ),
          SizedBox(height: 1.v),
          Padding(
            padding: EdgeInsets.only(
              left: 18.h,
              right: 32.h,
            ),
            child: _buildColorwhite(
              context,
              typesomething: "Camera Destination",
              typesomething1: recordDetailResponse['cameraDestination'],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildColumntypesomet1(BuildContext context) {
    String alarmLevel = recordDetailResponse['recommendAlarmLevel'].toString();
    String cleanedAlarmLevel = alarmLevel.replaceAll('Alarm ', '');
    String finishTime =
        recordDetailResponse['finishTime'] == "00:00:00 01-01-0001"
            ? "Not Finish"
            : recordDetailResponse['finishTime'];
    String AlarmAccountable = recordDetailResponse['alarmUser'] == null
        ? "AI Detect"
        : recordDetailResponse['alarmUser']['name'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Analysis",
              style: CustomTextStyles.titleLargeBluegray300,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15.h,
              right: 31.h,
            ),
            child: _buildColorwhite(
              context,
              typesomething: "AI Predicted",
              typesomething1:
                  recordDetailResponse['predictedPercent'].toString(),
            ),
          ),
          SizedBox(height: 3.v),
          Padding(
            padding: EdgeInsets.only(
              left: 15.h,
              right: 31.h,
            ),
            child: _buildColorwhite(
              context,
              typesomething: "Recommend Alarm Level",
              typesomething1: cleanedAlarmLevel,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15.h,
              right: 31.h,
            ),
            child: _buildColorwhite(
              context,
              typesomething: "Detected by",
              typesomething1: AlarmAccountable,
            ),
          ),
          SizedBox(height: 3.v),
          Padding(
            padding: EdgeInsets.only(
              left: 15.h,
              right: 31.h,
            ),
            child: _buildColorwhite(
              context,
              typesomething: "Finish time",
              typesomething1: finishTime,
            ),
          ),
          SizedBox(height: 3.v),
        ],
      ),
    );
  }

  /// Common widget

  Widget _buildColorwhite(
    BuildContext context, {
    required String typesomething,
    required String typesomething1,
  }) {
    return Container(
      decoration: AppDecoration.fillWhiteA,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 13.v),
          Padding(
            padding: EdgeInsets.only(right: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  typesomething,
                  style: CustomTextStyles.titleMediumOnPrimary.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.v),
                  child: Text(
                    typesomething1,
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: appTheme.blueGray300,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _buildUserResponsibility(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.v),
              child: Text(
                "Responsible users",
                style: CustomTextStyles.titleLargeBluegray300,
              ),
            ),
          ),
          ...recordDetailResponse['userResponsibilities']
              .map<Widget>(
                (user) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.v),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user['userName']}",
                          style: theme.textTheme.titleMedium,
                        ),
                        Divider()
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    )),
              )
              .toList(),
        ],
      ),
    );
  }
}
