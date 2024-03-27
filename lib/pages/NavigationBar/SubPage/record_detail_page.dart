import 'package:flutter/material.dart';
import 'package:facs_mobile/services/record_service.dart';
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
      "https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/${recordDetailResponse['videoRecord']['videoUrl']}?alt=media&token=93976c11-1da7-4aa7-a470-20e26a92a38c",
    )..initialize().then((_) {
        setState(() {});
      });
  }

  Future<void> finishActionAlarm(String recordId) async {
    await RecordService.finishActionPhase(recordId: recordId);
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i <= 5; i++)
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
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implement logic to confirm vote
                      Navigator.pop(context); // Close the dialog
                      RecordService.voteAlarm(
                          voteIn: _vote,
                          recordId: recordDetailResponse['recordId'],
                          context: context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "Camera ID",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "${recordDetailResponse["cameraId"]}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Location",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "${recordDetailResponse['cameraDestination']}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Rating Result",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "${recordDetailResponse['ratingResult']}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Record ID",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "${recordDetailResponse['recordId']}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "User Rating Percent",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "${recordDetailResponse['userRatingPercent']}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Predicted Percent",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "${recordDetailResponse['predictedPercent']}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Status",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "${recordDetailResponse['status']}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: _videoController.value.isInitialized
                        ? Container(
                            height: 200,
                            width: double.infinity,
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
                      "https://firebasestorage.googleapis.com/v0/b/final-capstone-project-f8bdd.appspot.com/o/${recordDetailResponse['imageRecord']['videoUrl']}?alt=media&token=93976c11-1da7-4aa7-a470-20e26a92a38c",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: recordDetailResponse['status'] == 'InAction'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Handle the action for the first button
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
                                  'Add More Action', // Change this to the label for the first button
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 16), // Add spacing between buttons
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
                                  'Finish Alarm', // Change this to the label for the second button
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
                                // Handle the case when status is 'InAlarm'
                                // (Optional: You can implement logic here)
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
                ],
              ),
            ),
    );
  }
}
