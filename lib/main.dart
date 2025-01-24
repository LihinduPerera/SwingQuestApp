import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swing_quest/api_client.dart';
import 'package:swing_quest/api_handler.dart';
import 'package:swing_quest/app.dart';
import 'package:swing_quest/dioClient.dart';
import 'package:swing_quest/pages/homePage.dart';

void main() {
  final dioClient = DioClient();
  final apiClient = ApiClient(dioClient: dioClient);
  runApp( MyApp(dioClient: dioClient, apiClient: apiClient,));
}