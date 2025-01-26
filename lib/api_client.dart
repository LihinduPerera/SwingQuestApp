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

  Future<void> updateUserCorrectAnswersCount(int userId, int correctAnswers) async {
  try {
    // Directly send the integer instead of wrapping it in a JSON object
    final response = await _dioClient.put(
      '/api/Users/$userId/correctAnswers',
      data: correctAnswers, // Send the value directly
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

  // New method for logging in a user
  Future<User?> loginUser(String username, String password) async {
  try {
    // Send a GET request to fetch users based on the username and password
    final response = await _dioClient.get(
      '/api/Users?name=$username&password=$password',
    );

    // Check if the response is not empty
    if (response.data.isEmpty) {
      // No users found for the given credentials, return null
      return null;
    }

    // Iterate over all the users returned
    for (var userData in response.data) {
      // Check if the username and password match
      if (userData['name'] == username && userData['password'] == password) {
        // If valid user, return the User object
        return User.fromJson(userData);
      }
    }

    // If no match is found, return null
    return null;
  } catch (e) {
    print("Error during login: $e");
    return null; // Return null if any error occurs during the API call
  }
}

}
