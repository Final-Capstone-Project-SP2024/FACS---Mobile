import 'package:flutter/material.dart';
import 'package:facs_mobile/services/record_service.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/record_detail_page.dart';

class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  final RecordService _recordServices = RecordService();
  List<Map<String, dynamic>> _records = [];
  bool _isLoading = false;
  int _page = 1;
  int _pageSize = 10;
  ScrollController _scrollController = ScrollController();

  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    _fetchRecords();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchRecords() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<Map<String, dynamic>> records = await _recordServices.getRecords(
        page: _page,
        pageSize: _pageSize,
        fromDate: _fromDate != null ? _fromDate!.toIso8601String() : null,
        toDate: _toDate != null ? _toDate!.toIso8601String() : null,
      );
      records.sort((a, b) => DateTime.parse(a['recordTime']).compareTo(DateTime.parse(b['recordTime'])));

      setState(() {
        _records.addAll(records);
        _isLoading = false;
        _page++;
      });
    } catch (e) {
      print('Error fetching records: $e');
      setState(() {
        _isLoading = false;
      });
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

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _fetchRecords();
    }
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
          _buildDateFilters(),
          Expanded(
            child: _buildTimeline(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () => _selectFromDate(context),
            child: Text(_fromDate != null ? 'From: ${_fromDate!.toString().substring(0, 10)}' : 'Select From Date'),
          ),
          ElevatedButton(
            onPressed: () => _selectToDate(context),
            child: Text(_toDate != null ? 'To: ${_toDate!.toString().substring(0, 10)}' : 'Select To Date'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _fromDate) {
      setState(() {
        _fromDate = picked;
      });
      _fetchRecords();
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _toDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _toDate) {
      setState(() {
        _toDate = picked;
      });
      _fetchRecords();
    }
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
        controller: _scrollController,
        itemCount: reversedRecords.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == reversedRecords.length) {
            return _buildLoadingIndicator();
          }

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

  Widget _buildLoadingIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
