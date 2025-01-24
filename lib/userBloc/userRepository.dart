import 'package:flutter/material.dart';
import 'package:swing_quest/api_client.dart';
import 'package:swing_quest/models/testModel.dart';

abstract class UserRepository {
 Future<List<User>> getAllUsers();
}

// class UserRepositoryImpl implements UserRepository{
//   final ApiClient _apiClient;

//   UserRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

//   @override
//   Future<User> getAllUsers() async {
//     try {
//       return await _apiClient.getAllUsers();
//     } catch (e) {
//       debugPrint('Error getting user data: $e');
//       rethrow;
//     }
//   }
// }

class UserRepositoryImpl implements UserRepository {
  final ApiClient _apiClient;

  UserRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<List<User>> getAllUsers() async {
    try {
      return await _apiClient.getAllUsers();
    } catch (e) {
      debugPrint('Error getting user data: $e');
      rethrow;
    }
  }
}