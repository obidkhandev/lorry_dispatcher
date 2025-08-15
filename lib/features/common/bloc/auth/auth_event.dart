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

  LoginEvent({required this.phone, required this.otp});
}

class CheckAuthEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
