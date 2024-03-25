import 'package:flutter/material.dart';
import 'package:facs_mobile/services/record_services.dart';

class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  List<dynamic> records = [];

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    dynamic data = await RecordServices.getLocation();

    setState(() {
      records = data != null ? data['data']['results'] : [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timeline Page'),
      ),
      body: ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Camera ID: ${records[index]['cameraId']}'),
            subtitle: Text('Record ID: ${records[index]['recordFollows'][0]['recordId']}'),
            onTap: () {
              // TODO: Handle tap action
            },
          );
        },
      ),
    );
  }
}