import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lorry_dispatcher/core/api/api.dart';
import 'package:lorry_dispatcher/core/api/api_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_interceptor.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient {
  late Dio _dio;

  DioClient(SharedPreferences preferences) {
    _dio = _createDio();

    try {
      _dio.interceptors.add(MySmartDioInterceptor(preferences));
    } catch (e) {
      debugPrint('SE:$e');
    }
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          requestHeader: true,
          responseHeader: false,
          error: true,
        ),
      );
    }
  }

  Dio get dio => _dio;

  Dio _createDio() => Dio(
    BaseOptions(
      baseUrl: ListAPI.baseUrl,
      receiveTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
      // Remove validateStatus - let Dio handle status codes naturally
      // This allows proper error handling in handleRequest
    ),
  );

  Future<Response> get(
      String url, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      // Convert non-DioException to DioException for consistent error handling
      throw DioException(
        requestOptions: RequestOptions(path: url),
        message: e.toString(),
        type: DioExceptionType.unknown,
      );
    }
  }

  Future<Response> delete(
      String url, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.delete(
        url,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: url),
        message: e.toString(),
        type: DioExceptionType.unknown,
      );
    }
  }

  Future<Response> post(
      String url, {
        Map<String, dynamic>? headers,
        dynamic data,
        Options? options,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: headers),
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: url),
        message: e.toString(),
        type: DioExceptionType.unknown,
      );
    }
  }

  Future<Response> patch(
      String url, {
        Map<String, dynamic>? headers,
        dynamic data,
        Options? options,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: headers),
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: url),
        message: e.toString(),
        type: DioExceptionType.unknown,
      );
    }
  }

  Future<Response> put(
      String url, {
        dynamic data,
        Options? options,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: url),
        message: e.toString(),
        type: DioExceptionType.unknown,
      );
    }
  }
}