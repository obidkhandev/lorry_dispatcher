part of 'auth_bloc.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool authenticated,
    int? retryAfter,
    @Default(UnknownFailure()) Failure? getOtpFailure,
    @Default(UnknownFailure()) Failure? loginFailure,
    @Default(UnknownFailure()) Failure? registerFailure,
    @Default(UnknownFailure()) Failure? otpVerifyFailure,
    @Default(Status.UNKNOWN) Status getOtpSt,
    @Default(Status.UNKNOWN) Status loginSt,
    @Default(Status.UNKNOWN) Status otpVerifySt,
    @Default(Status.UNKNOWN) Status registerSt,
    @Default(Status.UNKNOWN) Status checkAuthSt,
  }) = _AuthState;
}