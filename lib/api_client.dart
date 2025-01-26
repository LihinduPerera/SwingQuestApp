import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:swing_quest/api_ngrokUrl.dart';
import 'package:swing_quest/dioClient.dart';
import 'package:swing_quest/models/questionModel.dart';
import 'package:swing_quest/models/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final DioClient _dioClient;

  ApiClient({required DioClient dioClient}) : _dioClient = dioClient;

  Future<List<User>> getAllUsers() async {
    try {
      final response = await _dioClient.get('/api/Users');

      print('API Response Data: ${response.data}');

      final List<dynamic> jsonData = response.data;
      return jsonData.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error getting user data: $e');
      rethrow;
    }
  }

  Future<List<Question>> getQuestions() async {
    try {
      final response = await _dioClient
          .get('/api/Questions'); // Replace with actual endpoint

      print('API Response Data: ${response.data}');

      final List<dynamic> jsonData = response.data;
      return jsonData.map((json) => Question.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }

  Future<bool> getHostingStatus() async {
    try {
      final response = await _dioClient.get('/api/HostingStatus');
      return response.data;
    } catch (e) {
      debugPrint('Error getting hosting status: $e');
      rethrow;
    }
  }

  // Future<void> updateUserCorrectAnswersCount(int userId, int correctAnswersCount) async {
  //   try {
  //     final response = await _dioClient.put(
  //       '/api/Users/$userId',
  //       data: {'correctAnswersCount': correctAnswersCount},
  //     );
  //     print('User Correct Answers Updated: ${response.data}');
  //   } catch (e) {
  //     debugPrint('Error updating user correct answers: $e');
  //     rethrow;
  //   }
  // }
  Future<void> updateUserCorrectAnswersCount(int correctAnswers) async {
    try {
      final url = Uri.parse(
          '$ngrokUrl/api/Users/1/correctAnswers'); // Use the correct user ID

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body:
            json.encode(correctAnswers), // Send the raw integer value directly
      );

      if (response.statusCode == 204) {
        print('Correct answers count updated successfully');
      } else {
        throw Exception('Failed to update correct answers count');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to update correct answers count');
    }
  }
}
