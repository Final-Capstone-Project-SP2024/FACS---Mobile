import 'package:facs_mobile/pages/NavigationBar/SubPage/record_detail_page.dart';
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(height: 50),
          ),
          Expanded(
            child: _buildTimeline(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    if (_records.isEmpty) {
      return Center(
        child: Text(
          'No records available',
          style: TextStyle(fontSize: 16),
        ),
      );
    } else {
      final reversedRecords = List.from(_records.reversed);

      return ListView.builder(
        itemCount: reversedRecords.length,
        itemBuilder: (context, index) {
          final record = reversedRecords[index];
          final DateTime recordDateTime = DateTime.parse(record['recordTime']);
          final String formattedDateTime =
              '${recordDateTime.day}/${recordDateTime.month}/${recordDateTime.year} ${recordDateTime.hour}:${recordDateTime.minute}';
          Color cardColor;
          switch (record['status']) {
            case 'InFinish':
              cardColor = Colors.green;
              break;
            case 'Pending':
              cardColor = Colors.yellow;
              break;
            case 'InAlarm':
              cardColor = Colors.orange;
              break;
            case 'InVote':
              cardColor = Colors.red;
              break;
            case 'InAction':
              cardColor = Colors.red;
              break;
            default:
              cardColor = Colors.grey;
              break;
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecordDetail(
                              recordId: record['id'],
                              state: record['status'],
                            ),
                          ),
                        );
            },
            child: Card(
              color: cardColor,
              child: ListTile(
                title: Text('Date & Time: $formattedDateTime'),
                subtitle: Text('Status: ${record['status']}'),
              ),
            ),
          );
        },
      );
    }
  }

}
