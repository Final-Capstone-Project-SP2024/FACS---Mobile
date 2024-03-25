import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  // Method to determine the background color of the card based on detection status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'safe':
        return Colors.green;
      case 'potential':
        return Colors.yellow;
      case 'at_risk':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dummy detection status, will replace it later
    String detectionStatus = 'safe';

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(height: 40),
          ),
          Expanded(
            child: FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: 1.0 / 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  color: _getStatusColor(detectionStatus),
                  child: InkWell(
                    onTap: () {
                      // TODO : Handle card tap
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Fire Detection Status: $detectionStatus',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              // TODO : TIMELINE
            ),
          ),
        ],
      ),
    );
  }
}
