import 'package:flutter/material.dart';
import 'package:facs_mobile/services/record_service.dart';

class ActionPage extends StatefulWidget {
  final String recordId;

  ActionPage({required this.recordId});

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  int _selectedRating = -1; // Default value for no selection
  bool _isSubmitting = false;

  Future<void> addActionAlarm(String recordId, int rate) async {
    print(recordId);
    print(rate);
    await RecordService.actionAlarm(recordId: recordId, alarmLevel: rate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Rate the Fire',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red, // Set app bar color to red
        elevation: 0, // No shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select the Severity Level:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: List.generate(6, (index) {
                  if (index == 0) {
                    return _buildRatingTile(
                        'Fake Alarm',
                        'A false alarm with no real fire detected. No action required.',
                        index);
                  } else {
                    return _buildRatingTile(
                        'Fire Alarm $index',
                        'A fire alarm indicating the severity level $index. Immediate action may be required.',
                        index);
                  }
                }),
              ),
            ),
            SizedBox(height: 40),
            AnimatedOpacity(
              opacity: _isSubmitting ? 0.0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: ElevatedButton(
                onPressed: _isSubmitting
                    ? null
                    : () {
                        _submitRating();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Set button color to red
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isSubmitting
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18, // Button text size
                          fontWeight: FontWeight.bold, // Button text weight
                          color: Colors.white, // Button text color
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingTile(String title, String description, int index) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _selectedRating == index ? Colors.red : Colors.black,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          _selectedRating = index; // Set selected rating to index
        });
      },
      selected: _selectedRating == index,
      tileColor: _selectedRating == index ? Colors.grey[300] : null,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void _submitRating() {
    setState(() {
      _isSubmitting = true;
    });
    // Simulate API call
    addActionAlarm(widget.recordId, _selectedRating);
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isSubmitting = false;
        _selectedRating = -1; // Reset selected rating after submission
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rating submitted successfully!')),
      );
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    });
  }
}
