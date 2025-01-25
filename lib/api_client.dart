import 'package:flutter/material.dart';
import 'package:swing_quest/dioClient.dart';
import 'package:swing_quest/models/userModel.dart';

class ApiClient {
  final DioClient _dioClient;

  ApiClient({required DioClient dioClient}) : _dioClient = dioClient;

  Future<List<User>> getAllUsers() async {
    try {
      final response = await _dioClient.get('/api/Users');
      
      // Debugging line to print the response
      print('API Response Data: ${response.data}');
      
      final List<dynamic> jsonData = response.data;
      return jsonData.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error getting user data: $e');
      rethrow;
    }
  }
}