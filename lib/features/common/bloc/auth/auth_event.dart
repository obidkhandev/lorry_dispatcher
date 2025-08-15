part of 'auth_bloc.dart';

abstract class AuthEvent {}

class GetOtpEvent extends AuthEvent {
  final String phone;
  final Function() onSuccess;
  final Function() onError;

  GetOtpEvent({
    required this.phone,
    required this.onSuccess,
    required this.onError,
  });
}

class StartOtpTimerEvent extends AuthEvent {
  final int seconds;

  StartOtpTimerEvent(this.seconds);
}

class LoginEvent extends AuthEvent {
  final String phone;
  final String otp;
  final int role;

  LoginEvent({required this.phone, required this.otp, required this.role});
}

class OtpVerifyEvent extends AuthEvent {
  final String phone;
  final String otp;
  final int role;
  final Function() onSuccess;
  final Function() onError;

  OtpVerifyEvent({
    required this.phone,
    required this.otp,
    required this.role,
    required this.onSuccess,
    required this.onError,
  });
}

class CheckAuthEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
