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
          .get('/api/Questions');

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

  Future<void> updateUserCorrectAnswersCount(int userId, int correctAnswers) async {
  try {
    final response = await _dioClient.put(
      '/api/Users/$userId/correctAnswers',
      data: correctAnswers, 
    );

    if (response.statusCode == 204) {
      print('Correct answers count updated successfully');
    } else {
      print('Failed to update correct answers count');
      throw Exception('Failed to update correct answers count');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to update correct answers count');
  }
}

Future<User> registerUser(String name, String password) async {
    try {
      final response = await _dioClient.put(
        '/api/Users',
        data: {
          'name': name,
          'password': password,
        },
      );
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Error registering user: $e');
    }
  }

  Future<User?> loginUser(String username, String password) async {
  try {
    final response = await _dioClient.get(
      '/api/Users?name=$username&password=$password',
    );

    if (response.data.isEmpty) {
      return null;
    }
    for (var userData in response.data) {
      if (userData['name'] == username && userData['password'] == password) {
        return User.fromJson(userData);
      }
    }

    return null;
  } catch (e) {
    print("Error during login: $e");
    return null; 
  }
}

}
