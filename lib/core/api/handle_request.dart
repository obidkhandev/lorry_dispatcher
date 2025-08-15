import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lorry_dispatcher/core/api/api.dart';
import 'package:lorry_dispatcher/core/error/dio_exceptions_wrapper.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';

enum HttpMethod { GET, POST, PUT, PATCH, DELETE }

Future<Either<Failure, T>> handleRequest<T>({
  required String endpoint,
  required DioClient dioClient,
  required HttpMethod method,
  dynamic data,
  ResponseType? responseType,
  Map<String, dynamic>? queryParameters,
  Map<String, String>? headers,
  required FutureOr<T> Function(Response) onSuccess,
  int expectedStatusCode = 200,
  Duration? timeout,
}) async {
  try {
    Response response;

    final options = Options(
      headers: headers,
      responseType: responseType,
      receiveTimeout: timeout ?? const Duration(seconds: 30),
      sendTimeout: timeout ?? const Duration(seconds: 30),
    );

    switch (method) {
      case HttpMethod.GET:
        response = await dioClient.get(
          endpoint,
          queryParameters: queryParameters ?? data,
          options: options,
        );
        break;
      case HttpMethod.POST:
        response = await dioClient.post(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case HttpMethod.PUT:
        response = await dioClient.put(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case HttpMethod.PATCH:
        response = await dioClient.patch(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case HttpMethod.DELETE:
        response = await dioClient.delete(
          endpoint,
          queryParameters: queryParameters,
          options: options,
        );
        break;
    }

    if (kDebugMode) {
      debugPrint("✅ Request successful: ${response.statusCode}");
      debugPrint("Response data: ${response.data}");
    }

    // Check if response status code matches expected
    if (response.statusCode != expectedStatusCode) {
      if (kDebugMode) {
        debugPrint("❌ Unexpected status code: ${response.statusCode}");
        debugPrint("Response data: ${response.data}");
      }

      // Create a DioException for unexpected status codes
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        message: 'Unexpected status code: ${response.statusCode}',
      );
    }

    return Right(await onSuccess(response));

  } on DioException catch (e) {
    if (kDebugMode) {
      debugPrint("❌ DioException caught in handleRequest");
      debugPrint("Status Code: ${e.response?.statusCode}");
      debugPrint("Response Text: ${e.response?.data}");
      debugPrint("Error Message: ${e.message}");
    }
    final failure = DioExceptions.fromDioError(e);
    return Left(failure);

  } catch (e) {
    if (kDebugMode) {
      debugPrint("❌ Unexpected error in handleRequest: $e");
    }
    // Handle any other unexpected errors
    return Left(UnknownFailure(
      messageBuilder: (context) => 'An unexpected error occurred: ${e.toString()}',
      code: 'UNEXPECTED_ERROR',
    ));
  }
}