import 'package:facs_mobile/services/notification_services.dart';
import 'package:facs_mobile/services/record_service.dart';
import 'package:facs_mobile/services/camera_services.dart';

class DashboardData {
  final RecordService _recordServices = RecordService();
  Future<List<Map<String, dynamic>>> fetchRecentRecords() async {
    try {
      List<Map<String, dynamic>> records = await _recordServices.getRecords();
      records.sort((a, b) {
        DateTime aTime = DateTime.parse(a['recordTime']);
        DateTime bTime = DateTime.parse(b['recordTime']);
        DateTime now = DateTime.now();
        
        Duration differenceA = now.difference(aTime);
        Duration differenceB = now.difference(bTime);
        
        return differenceA.compareTo(differenceB);
      });
      List<Map<String, dynamic>> recentRecordIds = records
                              // .where((record) => record['status'] == 'InAction'
                              //                 || record['status'] == 'InAlarm'
                              //                 || record['status'] == 'InVote')
                              .take(1).toList();
      
      return recentRecordIds;
    } catch (e) {
      print('Error fetching records: $e');
      throw e;
    }
  }

  Future<List<dynamic>> fetchDisconnectedCameras() async {
    try {
      dynamic data = await CameraServices.getCamera();
      if (data != null && data['data'] != null) {
        List<dynamic> allCameras = data['data'];
        List<dynamic> disconnectedCameras = allCameras.where((camera) => camera['status'] == 'Disconnected'
                                                                      || camera['status'] == 'Disconnect'
                                                                      || camera['status'] == 'InActive'
                                                                      || camera['status'] == 'Inactive').toList();
        return disconnectedCameras;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching camera data: $e');
      throw e;
    }
  }
}
