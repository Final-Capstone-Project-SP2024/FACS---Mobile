import 'package:facs_mobile/app/pages/NavigationBar/SubPage/record_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:facs_mobile/services/record_service.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({Key? key}) : super(key: key);
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  List<Map<String, dynamic>> records = [];

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    try {
      final List<Map<String, dynamic>> fetchedRecords =
          await RecordService().getRecords(
        sortType: 1,
        colName: 'createdDate',
      );
      setState(() {
        records = fetchedRecords;
      });
    } catch (e) {
      print('Error fetching records: $e');
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'InAlarm':
        return Color.fromARGB(255, 255, 155, 155);
      case 'InAction':
        return Color.fromARGB(255, 255, 214, 165);
      case 'InFinish':
        return Color.fromARGB(255, 162, 204, 135);
      default:
        return Colors.grey;
    }
  }

  IconData _getIconData(String status) {
    switch (status) {
      case 'InAlarm':
        return Icons.priority_high;
      case 'InAction':
        return Icons.hourglass_top;
      case 'InFinish':
        return Icons.done;
      default:
        return Icons.error;
    }
  }

  Future<void> _refreshRecords() async {
    await fetchRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshRecords,
        child: records.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  final DateTime recordTime =
                      DateTime.parse(record['recordTime']);
                  final String formattedRecordTime =
                      DateFormat.yMMMd().add_jm().format(recordTime);

                  return GestureDetector(
                    onTap: () {
                      if (record['recordType']['recordTypeName'] !=
                          'ElectricalIncident')
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecordDetailPage(
                                recordId: record['id'],
                                state: record['status']),
                          ),
                        );
                      else
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'This is ElectricalIncident, unable to view'),
                              duration: Duration(seconds: 2)),
                        );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First part: Circle with icon
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: CircleAvatar(
                              backgroundColor:
                                  _getStatusColor(record['status']),
                              child: Icon(
                                _getIconData(record['status']),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Second part: Date, Time, and Status
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedRecordTime,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'Status: ${record['status']}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'Type: ${record['recordType']['recordTypeName']}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
