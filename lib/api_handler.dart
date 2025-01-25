import 'dart:convert';
import 'package:swing_quest/api_ngrokUrl.dart';
import 'package:http/http.dart' as http;
import 'package:swing_quest/models/userModel.dart';

class ApiHandler {
  final String baseUri = ngrokUrl;

  Future<List<User>> getUserData() async {
    List<User> data = [];

    final uri = Uri.parse(baseUri);

    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      // Print the response code for debugging
      print('Response status: ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        // Success: Parse JSON data
        final List<dynamic> jsonData = json.decode(response.body);
        data = jsonData.map((json) => User.fromJson(json)).toList();
      } 
    } catch (e) {
      // Catch network or other errors
      print('Error occurred: $e');
      return data;
    }

    return data;
  }
}
