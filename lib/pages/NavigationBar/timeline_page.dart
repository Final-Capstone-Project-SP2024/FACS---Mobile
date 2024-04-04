import 'package:flutter/material.dart';
import 'package:facs_mobile/services/record_service.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/action/action_page.dart';

class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  final RecordService _recordServices = RecordService();
  List<Map<String, dynamic>> _records = [];

  Future<void> _fetchRecords() async {
    try {
      List<Map<String, dynamic>> records = await _recordServices.getRecords();

      // Sort the records in ascending order based on recordTime
      records.sort((a, b) => DateTime.parse(a['recordTime']).compareTo(DateTime.parse(b['recordTime'])));

      setState(() {
        _records = records;
      });
    } catch (e) {
      print('Error fetching records: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch records. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }




  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timeline'),
      ),
      body: _buildTimeline(),
    );
  }

  Widget _buildTimeline() {
    if (_records.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      final reversedRecords = List.from(_records.reversed);

      return ListView.builder(
        itemCount: reversedRecords.length,
        itemBuilder: (context, index) {
          final record = reversedRecords[index];
          final DateTime recordDateTime = DateTime.parse(record['recordTime']);
          // Format date and time as a string
          final String formattedDateTime =
              '${recordDateTime.day}/${recordDateTime.month}/${recordDateTime.year} ${recordDateTime.hour}:${recordDateTime.minute}';
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActionPage(recordId: record['id']),
                ),
              );
            },
            child: ListTile(
              title: Text('Date & Time: $formattedDateTime'),
              subtitle: Text('Status: ${record['status']}'),
            ),
          );
        },
      );
    }
  }

}
