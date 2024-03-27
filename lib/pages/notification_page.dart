import 'package:flutter/material.dart';
import 'package:facs_mobile/services/notification_services.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/record_detail_page.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> notificationData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNotificationData();
  }

  Future<void> fetchNotificationData() async {
    dynamic dataFetch = await NotificationService.getNotification();
    setState(() {
      notificationData = dataFetch != null ? dataFetch['data'] : [];
      isLoading = false;
    });
    print(notificationData);
  }

  // Define a function to determine the color based on status
  Color getStatusColor(String status) {
    if (status == 'InAlarm') {
      return Colors.orange[100]!;
    } else if (status == 'InVote') {
      return Colors.yellow[100]!;
    } else if (status == 'EndVote') {
      return Colors.amber[100]!;
    } else if (status == 'InAction') {
      return Colors.deepOrangeAccent[100]!;
    }
    return Colors.grey[100]!; // Default color
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Alarm Notifications'),
        backgroundColor: Colors.red, // Set app bar color to red
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : notificationData.isNotEmpty
              ? ListView.builder(
                  itemCount: notificationData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecordDetail(
                              recordId: notificationData[index]['recordId'],
                              state: notificationData[index]['status'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color:
                            getStatusColor(notificationData[index]['status']),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          title: Text(
                            notificationData[index]['locationName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red, // Set text color to red
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4),
                              Text(
                                'Camera: ${notificationData[index]['cameraName']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Location: ${notificationData[index]['cameraDestination']}',
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Status: ${notificationData[index]['status']}',
                              )
                            ],
                          ),
                          trailing: Icon(
                            Icons.fire_extinguisher, // Fire icon
                            color: Colors.red, // Set icon color to red
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text('No notifications available'),
                ),
    );
  }
}
