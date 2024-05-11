import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:facs_mobile/data/helpers/access_token_helper.dart';

class RecordRepository {
  static const String apiUrl =
      'https://firealarmcamerasolution.azurewebsites.net/api/v1';
  Future<List<Map<String, dynamic>>> getRecords(
      {int? page,
      int? pageSize,
      int? sortType,
      String? colName,
      String? fromDate,
      String? toDate,
      String? status}) async {
    try {
      String url = '$apiUrl/Record?';
      if (page != null && pageSize != null) {
        url += 'Page=$page&PageSize=$pageSize';
      }
      if (sortType != null) {
        url += '&SortType=$sortType';
      }
      if (colName != null) {
        url += '&ColName=$colName';
      }
      if (fromDate != null) {
        url += '&FromDate=$fromDate';
      }
      if (toDate != null) {
        url += '&ToDate=$toDate';
      }
      if (status != null) {
        url += '&status=$status';
      }
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${AccessTokenHelper.getAccessToken()}'
        },
      );

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
      final response = await http.get(Uri.parse('$apiUrl/Record/$recordId'),
          headers: {
            'Authorization': 'Bearer ${AccessTokenHelper.getAccessToken()}'
          });
      if (response.statusCode == 200) {
        print(response.body);
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
          'Authorization': 'Bearer ${AccessTokenHelper.getAccessToken()}',
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
                'Authorization': 'Bearer ${AccessTokenHelper.getAccessToken()}',
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
                'Authorization': 'Bearer ${AccessTokenHelper.getAccessToken()}',
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
                'Authorization': 'Bearer ${AccessTokenHelper.getAccessToken()}',
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

  static Future<void> addEvidence(List<int> imageData, String recordId) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/Record/$recordId/addEvidence'),
      );
      request.headers['Authorization'] =
          'Bearer ${AccessTokenHelper.getAccessToken()}';
      request.files.add(
        http.MultipartFile.fromBytes(
          'evidenAdding',
          imageData,
          filename: 'evidence.jpg',
        ),
      );
      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('Evidence added successfully');
      } else {
        print('Failed to add evidence. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in addEvidence: $e');
    }
  }
}
