import 'package:facs_mobile/pages/NavigationBar/SubPage/add_evidence.page.dart';
import 'package:flutter/material.dart';
import 'package:facs_mobile/services/record_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/action/action_page.dart';

class RecordDetail extends StatefulWidget {
  final String recordId;
  final String state;

  RecordDetail({required this.recordId, required this.state});

  @override
  _RecordDetailPageState createState() => _RecordDetailPageState();
}

class _RecordDetailPageState extends State<RecordDetail> {
  dynamic recordDetailResponse;
  late VideoPlayerController _videoController;
  bool _isPlaying = false;
  int _vote = 0;

  @override
  void initState() {
    super.initState();
    getRecordDetailId(widget.recordId);
  }

  void _initializeVideoController() {
    _videoController = VideoPlayerController.network(
    "https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/VideoRecord%2F${recordDetailResponse['videoRecord']['videoUrl']}?alt=media&token=93976c11-1da7-4aa7-a470-20e26a92a38c",
    //"https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/VideoRecord%2Fincident_12-4-2024-18-47-29.mp4?alt=media&token=93976c11-1da7-4aa7-a470-20e26a92a38c"
    )..initialize().then((_) {
        setState(() {});
      });
  }

  Future<void> finishActionAlarm(String recordId) async {
    await RecordService.finishActionPhase(recordId: recordId);
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() => {
          //   = File(returnedImage!.path);
          //
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

  void _showVoteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Rate the fire'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('How would you rate the severity of the fire?'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i <= 2; i++)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _vote = i; // Update the selected vote
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _vote == i ? Colors.red : null,
                          ),
                          child: Text('$i'),
                        ),
                    ],
                  ),
                  SizedBox(height: 10), // Adjust spacing between rows
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 3; i <= 5; i++)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _vote = i; // Update the selected vote
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _vote == i ? Colors.red : null,
                          ),
                          child: Text('$i'),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implement logic to confirm vote
                      Navigator.pop(context); // Close the dialog
                      RecordService.voteAlarm(
                        voteIn: _vote,
                        recordId: recordDetailResponse['recordId'],
                        context: context,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Vote submitted successfully!')),
                      );
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Confirm'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Alarm Record Details'),
        backgroundColor: Colors.red, // Set app bar color to red
      ),
      body: recordDetailResponse == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors
                              .blue, // Set camera icon color to blue to represent camera-related topic
                        ),
                        SizedBox(
                            width: 8), // Add spacing between the icon and text
                        Text(
                          "Camera Destination: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                            width: 8), // Add spacing between the icon and text
                        Expanded(
                          child: Text(
                            "${recordDetailResponse['cameraDestination']}",
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow
                                .ellipsis, // Allow text to overflow with ellipsis if too long
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors
                              .amber, // Set star icon color to amber to represent rating
                        ),
                        SizedBox(
                            width: 8), // Add spacing between the icon and text
                        Text(
                          "Rating Result: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                            width: 8), // Add spacing between the icon and text
                        Text(
                          "${recordDetailResponse['ratingResult']}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.sentiment_satisfied,
                          color: Colors
                              .green, // Set satisfaction icon color to green to represent positive rating
                        ),
                        SizedBox(
                            width: 8), // Add spacing between the icon and text
                        Text(
                          "User Rating Percent: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                            width: 8), // Add spacing between the icon and text
                        Text(
                          "${recordDetailResponse['userRatingPercent']}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          "Predicted Percent: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "${recordDetailResponse['predictedPercent']}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors
                              .orange, // Set the warning icon color to orange to represent status
                        ),
                        SizedBox(
                            width: 8), // Add spacing between the icon and text
                        Text(
                          "Status: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                            width: 8), // Add spacing between the icon and text
                        Text(
                          "${recordDetailResponse['status']}",
                          style: TextStyle(
                            fontSize: 16,
                            color: recordDetailResponse['status'] == 'Active'
                                ? Colors
                                    .green // Set the text color to green if status is Active
                                : Colors
                                    .red, // Set the text color to red for other statuses
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'User Vote:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors
                            .red,
                      ),
                    ),
                    subtitle: recordDetailResponse['userRatings'] != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              recordDetailResponse['userRatings'].length,
                              (index) {
                                var userRating =
                                    recordDetailResponse['userRatings'][index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.how_to_reg,
                                        color: Colors
                                            .red,
                                      ),
                                      SizedBox(
                                          width:
                                              8),
                                      Text(
                                        'XXX_001: ${userRating['rating']}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Text(
                            'No user ratings available.',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                  ListTile(
                    title: Text(
                      'User Action:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors
                            .red,
                      ),
                    ),
                    subtitle: recordDetailResponse['userVoting'] != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              recordDetailResponse['userVoting'].length,
                              (index) {
                                var userVote =
                                    recordDetailResponse['userVoting'][index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.fireplace,
                                        color: Colors
                                            .red,
                                      ),
                                      SizedBox(
                                          width:
                                              8),
                                      Text(
                                        ' Level ${userVote['voteLevel']} - ${userVote['voteType']}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Text(
                            'No user voting available.',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Fire Detect Video',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: _videoController.value.isInitialized
                        ? Container(
                            height: 200,
                            width: 500,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AspectRatio(
                                  aspectRatio:
                                      _videoController.value.aspectRatio,
                                  child: VideoPlayer(_videoController),
                                ),
                                if (!_isPlaying)
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _isPlaying = true;
                                      });
                                      _videoController.play();
                                    },
                                    child: Icon(Icons.play_arrow),
                                  ),
                              ],
                            ),
                          )
                        : CircularProgressIndicator(),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Fire Image',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/ImageRecord%2F${recordDetailResponse['imageRecord']['imageUrl']}?alt=media&token=93976c11-1da7-4aa7-a470-20e26a92a38c",
                      width: 275,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: recordDetailResponse['evidences'].length,
                    itemBuilder: (context, index) {
                      String imageUrl =
                          recordDetailResponse['evidences'][index];
                      return Center(
                        child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/ImageEvidene%2F${recordDetailResponse['evidences'][index]}?alt=media&token=73060cb9-20ae-4cf9-888d-c89bf80abc6c",
                          width: 275,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: recordDetailResponse['status'] == 'InAction'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ActionPage(
                                            recordId: recordDetailResponse[
                                                'recordId'])),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Add More Action',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 16),
                              ElevatedButton(
                                onPressed: () {
                                  finishActionAlarm(
                                      recordDetailResponse['recordId']);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Finish submitted successfully!')),
                                  );
                                  // Handle the action for the second button
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Finish Alarm',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (recordDetailResponse['status'] == 'InVote') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ActionPage(
                                          recordId: recordDetailResponse[
                                              'recordId'])),
                                );
                              } else if (recordDetailResponse['status'] ==
                                  'InAlarm') {
                                _showVoteDialog();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              recordDetailResponse['status'] == 'InVote'
                                  ? 'Action Alarm'
                                  : recordDetailResponse['status'] == 'InAlarm'
                                      ? 'Rate Fire'
                                      : 'Default Text',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),

                  //? Add Evidence

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TakePictureScreen(
                                  recordId: recordDetailResponse['recordId'])),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Add Evidence',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
