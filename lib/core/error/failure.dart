import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ==================== FAILURES ====================
// These are returned by use cases and presented to UI

/// Base failure class with localization support
abstract class Failure extends Equatable {
  final String Function(BuildContext context) messageBuilder;
  final String? code;

  const Failure(
      this.messageBuilder, {
        this.code,
      });

  /// Get localized message for the current context
  String getMessage(BuildContext context) => messageBuilder(context);

  @override
  List<Object?> get props => [code];
}

/// Server related failures
class ServerFailure extends Failure {
  const ServerFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultServerMessage);

  static String _defaultServerMessage(BuildContext context) {
    // Replace with your localization: S.of(context).serverErrorMessage
    return 'Server error occurred. Please try again later.';
  }
}

/// Network connection failures
class ConnectionFailure extends Failure {
  const ConnectionFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultConnectionMessage);

  static String _defaultConnectionMessage(BuildContext context) {
    // Replace with your localization: S.of(context).connectionErrorMessage
    return 'No internet connection. Please check your network.';
  }
}

/// Bad response format failures
class BadResponseFailure extends Failure {
  const BadResponseFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultBadResponseMessage);

  static String _defaultBadResponseMessage(BuildContext context) {
    // Replace with your localization: S.of(context).badResponseMessage
    return 'Invalid response format. Please try again.';
  }
}

/// Authentication failures
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultAuthMessage);

  static String _defaultAuthMessage(BuildContext context) {
    // Replace with your localization: S.of(context).authenticationErrorMessage
    return 'Authentication failed. Please login again.';
  }
}

/// Unauthorized access failures
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultUnauthorizedMessage);

  static String _defaultUnauthorizedMessage(BuildContext context) {
    // Replace with your localization: S.of(context).unauthorizedMessage
    return 'You are not authorized to access this resource.';
  }
}

/// Forbidden access failures
class ForbiddenFailure extends Failure {
  const ForbiddenFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultForbiddenMessage);

  static String _defaultForbiddenMessage(BuildContext context) {
    // Replace with your localization: S.of(context).forbiddenMessage
    return 'Access forbidden. You don\'t have permission.';
  }
}

/// Resource not found failures
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultNotFoundMessage);

  static String _defaultNotFoundMessage(BuildContext context) {
    // Replace with your localization: S.of(context).notFoundMessage
    return 'The requested resource was not found.';
  }
}

/// Validation failures
class ValidationFailure extends Failure {
  final Map<String, dynamic>? validationErrors;

  const ValidationFailure({
    this.validationErrors,
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultValidationMessage);

  static String _defaultValidationMessage(BuildContext context) {
    // Replace with your localization: S.of(context).validationErrorMessage
    return 'Please check your input and try again.';
  }
}

/// Cache related failures
class CacheFailure extends Failure {
  const CacheFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultCacheMessage);

  static String _defaultCacheMessage(BuildContext context) {
    // Replace with your localization: S.of(context).cacheErrorMessage
    return 'Cache error occurred. Please refresh.';
  }
}

/// Timeout failures
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultTimeoutMessage);

  static String _defaultTimeoutMessage(BuildContext context) {
    // Replace with your localization: S.of(context).timeoutMessage
    return 'Request timed out. Please try again.';
  }
}

/// Permission failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultPermissionMessage);

  static String _defaultPermissionMessage(BuildContext context) {
    // Replace with your localization: S.of(context).permissionErrorMessage
    return 'Permission denied. Please grant the required permissions.';
  }
}

/// File system failures
class FileSystemFailure extends Failure {
  const FileSystemFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultFileSystemMessage);

  static String _defaultFileSystemMessage(BuildContext context) {
    // Replace with your localization: S.of(context).fileSystemErrorMessage
    return 'File system error occurred. Please try again.';
  }
}

/// Business logic failures
class BusinessLogicFailure extends Failure {
  const BusinessLogicFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultBusinessLogicMessage);

  static String _defaultBusinessLogicMessage(BuildContext context) {
    // Replace with your localization: S.of(context).businessLogicErrorMessage
    return 'Operation failed. Please check your input.';
  }
}

/// Unknown failures
class UnknownFailure extends Failure {
  const UnknownFailure({
    String Function(BuildContext context)? messageBuilder,
    super.code,
  }) : super(messageBuilder ?? _defaultUnknownMessage);

  static String _defaultUnknownMessage(BuildContext context) {
    // Replace with your localization: S.of(context).unknownErrorMessage
    return 'An unexpected error occurred. Please try again.';
  }
}

