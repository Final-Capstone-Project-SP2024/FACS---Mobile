import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'user_services.dart';
import 'package:facs_mobile/pages/home_page.dart';
import 'package:flutter/material.dart';

class RecordService {
  static const String apiUrl =
      'https://firealarmcamerasolution.azurewebsites.net/api/v1';
  Future<List<Map<String, dynamic>>> getRecords() async {
    // API URL
    final apiUrl = 'https://firealarmcamerasolution.azurewebsites.net/api/v1/Record';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> results = jsonData['results'];
        return results.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load records');
      }
    } catch (e) {
      throw Exception('Failed to load records: $e');
    }
  }

  static Future<dynamic> getRecordDetail(String recordId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/Record/$recordId'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<void> voteAlarm({
    required int voteIn,
    required String recordId,
    required BuildContext context,
  }) async {
    try {
      BuildContext _context = context;

      final response = await http.post(
        Uri.parse('$apiUrl/Record/$recordId/vote'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${UserServices.accessToken}',
        },
        body: jsonEncode({'levelRating': voteIn}),
      );

      if (response.statusCode == 200) {
        Navigator.pushNamed(_context, '/anotherRoute');
      } else {
        ScaffoldMessenger.of(_context).showSnackBar(
          SnackBar(content: Text('Voting failed')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    }
  }

  static Future<bool> actionAlarm({
    required String recordId,
    required int alarmLevel,
  }) async {
    try {
      final response =
          await http.post(Uri.parse('$apiUrl/Record/$recordId/action'),
              headers: <String, String>{
                'Authorization': 'Bearer ${UserServices.accessToken}',
                'Content-Type': 'application/json',
              },
              body: jsonEncode({'actionId': alarmLevel}));
      if (response.statusCode == 200) {
        print("thanh cong");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<bool> finishVotePhase({required String recordId}) async {
    try {
      final response =
          await http.post(Uri.parse('$apiUrl/Record/$recordId/endvote'),
              headers: <String, String>{
                'Authorization': 'Bearer ${UserServices.accessToken}',
                'Content-Type': 'application/json',
              },
              body: jsonEncode({'actionId': 6}));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<bool> finishActionPhase({required String recordId}) async {
    try {
      final response =
          await http.post(Uri.parse('$apiUrl/Record/$recordId/action'),
              headers: <String, String>{
                'Authorization': 'Bearer ${UserServices.accessToken}',
                'Content-Type': 'application/json',
              },
              body: jsonEncode({'actionId': 6}));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
