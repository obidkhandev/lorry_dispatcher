import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';

/// Dio exception wrapper that converts DioExceptions to appropriate Failures
class DioExceptions {
  /// Convert DioException to appropriate Failure with localized messages
  static Failure fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return TimeoutFailure(
          messageBuilder: (context) => _getTimeoutMessage(context),
          code: 'CONNECTION_TIMEOUT',
        );


      case DioExceptionType.sendTimeout:
        return TimeoutFailure(
          messageBuilder: (context) => _getSendTimeoutMessage(context),
          code: 'SEND_TIMEOUT',
        );

      case DioExceptionType.receiveTimeout:
        return TimeoutFailure(
          messageBuilder: (context) => _getReceiveTimeoutMessage(context),
          code: 'RECEIVE_TIMEOUT',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(dioException);

      case DioExceptionType.connectionError:
        return ConnectionFailure(
          messageBuilder: (context) => _getConnectionErrorMessage(context),
          code: 'CONNECTION_ERROR',
        );

      case DioExceptionType.cancel:
        return UnknownFailure(
          messageBuilder: (context) => _getRequestCancelledMessage(context),
          code: 'REQUEST_CANCELLED',
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(
          messageBuilder: (context) => _getBadCertificateMessage(context),
          code: 'BAD_CERTIFICATE',
        );

      case DioExceptionType.unknown:
      default:
        return _handleUnknownError(dioException);
    }
  }

  /// Handle bad response based on status code
  static Failure _handleBadResponse(DioException dioException) {
    final statusCode = dioException.response?.statusCode;
    final responseData = dioException.response?.data;

    switch (statusCode) {
      case 400:
      // Extract user message first, if available use it directly
        final userMessage = _extractUserMessage(responseData);
        if (userMessage != null && userMessage.isNotEmpty) {
          // For specific business logic errors in 400 responses
          return BusinessLogicFailure(
            messageBuilder: (context) => userMessage,
            code: 'BAD_REQUEST_WITH_MESSAGE_400',
          );
        }
        // Fall back to generic bad request
        return BadRequestFailure(
          messageBuilder: (context) => _getBadRequestMessage(context, responseData),
          code: 'BAD_REQUEST_400',
        );

      case 401:
        return UnauthorizedFailure(
          messageBuilder: (context) => _getUnauthorizedMessage(context, responseData),
          code: 'UNAUTHORIZED_401',
        );

      case 403:
        return ForbiddenFailure(
          messageBuilder: (context) => _getForbiddenMessage(context, responseData),
          code: 'FORBIDDEN_403',
        );

      case 404:
        return NotFoundFailure(
          messageBuilder: (context) => _getNotFoundMessage(context, responseData),
          code: 'NOT_FOUND_404',
        );

      case 409:
        return BusinessLogicFailure(
          messageBuilder: (context) => _getConflictMessage(context, responseData),
          code: 'CONFLICT_409',
        );

      case 422:
        return ValidationFailure(
          validationErrors: _extractValidationErrors(responseData),
          messageBuilder: (context) => _getValidationMessage(context, responseData),
          code: 'VALIDATION_422',
        );

      case 429:
        return ServerFailure(
          messageBuilder: (context) => _getTooManyRequestsMessage(context),
          code: 'TOO_MANY_REQUESTS_429',
        );

      case 500:
        return ServerFailure(
          messageBuilder: (context) => _getInternalServerErrorMessage(context),
          code: 'INTERNAL_SERVER_ERROR_500',
        );

      case 502:
        return ServerFailure(
          messageBuilder: (context) => _getBadGatewayMessage(context),
          code: 'BAD_GATEWAY_502',
        );

      case 503:
        return ServerFailure(
          messageBuilder: (context) => _getServiceUnavailableMessage(context),
          code: 'SERVICE_UNAVAILABLE_503',
        );

      case 504:
        return TimeoutFailure(
          messageBuilder: (context) => _getGatewayTimeoutMessage(context),
          code: 'GATEWAY_TIMEOUT_504',
        );

      default:
        return ServerFailure(
          messageBuilder: (context) => _getGenericServerErrorMessage(context, statusCode),
          code: 'SERVER_ERROR_$statusCode',
        );
    }
  }

  /// Handle unknown errors
  static Failure _handleUnknownError(DioException dioException) {
    // Check if it's a network-related error
    if (dioException.message?.contains('network') == true ||
        dioException.message?.contains('connection') == true ||
        dioException.message?.contains('host') == true) {
      return ConnectionFailure(
        messageBuilder: (context) => _getConnectionErrorMessage(context),
        code: 'NETWORK_ERROR',
      );
    }

    return UnknownFailure(
      messageBuilder: (context) => _getUnknownErrorMessage(context),
      code: 'UNKNOWN_ERROR',
    );
  }

  /// Extract validation errors from response data
  static Map<String, dynamic>? _extractValidationErrors(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      // Common validation error formats
      if (responseData.containsKey('errors')) {
        return responseData['errors'] as Map<String, dynamic>?;
      }
      if (responseData.containsKey('validation_errors')) {
        return responseData['validation_errors'] as Map<String, dynamic>?;
      }
      if (responseData.containsKey('field_errors')) {
        return responseData['field_errors'] as Map<String, dynamic>?;
      }
    }
    return null;
  }

  /// Extract user-friendly message from response data - ENHANCED VERSION
  static String? _extractUserMessage(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      // Common message fields - prioritizing 'detail' for your API
      final messageKeys = [
        'detail',        // Your API uses this field
        'message',
        'error_message',
        'user_message',
        'error',
        'msg',
        'description',
      ];

      for (final key in messageKeys) {
        if (responseData.containsKey(key)) {
          final value = responseData[key];
          if (value != null && value.toString().trim().isNotEmpty) {
            return value.toString();
          }
        }
      }
    }

    // If responseData is a string, return it directly
    if (responseData is String && responseData.trim().isNotEmpty) {
      return responseData;
    }

    return null;
  }

  // ==================== LOCALIZED MESSAGE METHODS ====================

  static String _getTimeoutMessage(BuildContext context) {
    return 'Connection timeout. Please check your internet and try again.';
  }

  static String _getSendTimeoutMessage(BuildContext context) {
    return 'Send timeout. Please try again.';
  }

  static String _getReceiveTimeoutMessage(BuildContext context) {
    return 'Receive timeout. Please try again.';
  }

  static String _getConnectionErrorMessage(BuildContext context) {
    return 'No internet connection. Please check your network settings.';
  }

  static String _getRequestCancelledMessage(BuildContext context) {
    return 'Request was cancelled.';
  }

  static String _getBadCertificateMessage(BuildContext context) {
    return 'Security certificate error. Please try again later.';
  }

  static String _getBadRequestMessage(BuildContext context, dynamic responseData) {
    final userMessage = _extractUserMessage(responseData);
    if (userMessage != null) return userMessage;

    return 'Invalid request. Please check your input and try again.';
  }

  static String _getUnauthorizedMessage(BuildContext context, dynamic responseData) {
    final userMessage = _extractUserMessage(responseData);
    if (userMessage != null) return userMessage;

    return 'Session expired. Please login again.';
  }

  static String _getForbiddenMessage(BuildContext context, dynamic responseData) {
    final userMessage = _extractUserMessage(responseData);
    if (userMessage != null) return userMessage;

    return 'Access denied. You don\'t have permission for this action.';
  }

  static String _getNotFoundMessage(BuildContext context, dynamic responseData) {
    final userMessage = _extractUserMessage(responseData);
    if (userMessage != null) return userMessage;

    return 'The requested resource was not found.';
  }

  static String _getConflictMessage(BuildContext context, dynamic responseData) {
    final userMessage = _extractUserMessage(responseData);
    if (userMessage != null) return userMessage;

    return 'Conflict occurred. The resource may have been modified.';
  }

  static String _getValidationMessage(BuildContext context, dynamic responseData) {
    final userMessage = _extractUserMessage(responseData);
    if (userMessage != null) return userMessage;

    return 'Please check your input and try again.';
  }

  static String _getTooManyRequestsMessage(BuildContext context) {
    return 'Too many requests. Please wait a moment and try again.';
  }

  static String _getInternalServerErrorMessage(BuildContext context) {
    return 'Server error occurred. Please try again later.';
  }

  static String _getBadGatewayMessage(BuildContext context) {
    return 'Server temporarily unavailable. Please try again later.';
  }

  static String _getServiceUnavailableMessage(BuildContext context) {
    return 'Service temporarily unavailable. Please try again later.';
  }

  static String _getGatewayTimeoutMessage(BuildContext context) {
    return 'Server timeout. Please try again later.';
  }

  static String _getGenericServerErrorMessage(BuildContext context, int? statusCode) {
    return 'Server error occurred. Please try again later.';
  }

  static String _getUnknownErrorMessage(BuildContext context) {
    return 'An unexpected error occurred. Please try again.';
  }
}