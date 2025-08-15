import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:lorry_dispatcher/core/values/app_strings.dart';
import 'package:lorry_dispatcher/features/common/data/repository/auth.dart';
import 'package:lorry_dispatcher/features/common/domain/repository/auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;
  Timer? _otpTimer;

  AuthBloc(this.authRepository) : super(AuthState()) {
    on<LogoutEvent>(_logout);
    on<CheckAuthEvent>(_checkAuth);
    on<GetOtpEvent>(_onGetOtpRequested);
    on<StartOtpTimerEvent>(_onStartOtpTimer);
    on<OtpVerifyEvent>(_otpVerify);
  }

  @override
  Future<void> close() {
    _otpTimer?.cancel();
    return super.close();
  }

  Future<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    await authRepository.logout();
  }

  Future<void> _checkAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    final res = await authRepository.checkUserToAuth();
    res.fold((f) => emit(state.copyWith(checkAuthSt: Status.ERROR)), (success) {
      emit(
        state.copyWith(
          checkAuthSt: success ? Status.Authenticated : Status.Unauthenticated,
        ),
      );
    });
  }

  Future<void> _onGetOtpRequested(
    GetOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(getOtpSt: Status.LOADING));
    final response = await authRepository.getOtp(event.phone);
    response.fold(
      (f) {
        emit(state.copyWith(getOtpFailure: f, getOtpSt: Status.ERROR));
        event.onError();
      },
      (success) {
        event.onSuccess();
        emit(state.copyWith(getOtpSt: Status.SUCCESS));
        add(StartOtpTimerEvent(120));
      },
    );
  }

  Future<void> _otpVerify(OtpVerifyEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(otpVerifySt: Status.LOADING));
    final response = await authRepository.otpVerifyCode(
      code: event.otp,
      phone: event.phone,
      role: event.role,
    );
    response.fold(
      (f) {
        emit(state.copyWith(otpVerifyFailure: f, otpVerifySt: Status.ERROR));
        event.onError();
      },
      (success) {
        event.onSuccess();
        emit(state.copyWith(otpVerifySt: Status.SUCCESS));
      },
    );
  }

  Future<void> _onStartOtpTimer(
    StartOtpTimerEvent event,
    Emitter<AuthState> emit,
  ) async {
    _otpTimer?.cancel(); // Cancel any existing timer

    emit(state.copyWith(retryAfter: event.seconds)); // Set initial retryAfter

    // Create a stream that emits every second
    await for (final _ in Stream.periodic(const Duration(seconds: 1))) {
      if (state.retryAfter! > 0) {
        emit(state.copyWith(retryAfter: state.retryAfter! - 1));
      } else {
        break; // Exit the loop when countdown reaches 0
      }
    }
  }
}
