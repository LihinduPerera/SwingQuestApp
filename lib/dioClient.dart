import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:swing_quest/api_ngrokUrl.dart';

class DioClient {
  late final Dio _dio;
  static String baseUrl = ngrokUrl;

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        return handler.next(error);
      },
    ));
  }

  Future<Response> get(String path, {Options? options}) async {
    try {
      return await _dio.get(path, options: options);
    } on DioException catch (e) {
      throw await _handleError(e);
    }
  }
  
  Future<Response> put(String path, {data, Options? options}) async {
    try {
      final response = await _dio.put(path, data: data, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> _handleError(DioException error) async {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException('Connection timed out. Please check your internet connection.', error.requestOptions.connectTimeout);
      case DioExceptionType.connectionError:
        throw const SocketException('No internet connection');
      default:
        throw error;
    }
  }
}