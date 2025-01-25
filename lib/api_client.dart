import 'package:flutter/material.dart';
import 'package:swing_quest/dioClient.dart';
import 'package:swing_quest/models/questionModel.dart';
import 'package:swing_quest/models/userModel.dart';

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
      final response = await _dioClient.get('/api/Questions');  // Replace with actual endpoint

      print('API Response Data: ${response.data}');
      
      final List<dynamic> jsonData = response.data;
      return jsonData.map((json) => Question.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }
}