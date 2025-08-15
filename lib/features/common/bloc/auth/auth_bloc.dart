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

  AuthBloc(this.authRepository) : super(AuthState()) {
    on<LogoutEvent>(_logout);
    on<CheckAuthEvent>(_checkAuth);
    on<GetOtpEvent>(_onGetOtpRequested);
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
        emit(
          state.copyWith(
            getOtpFailure: f,
            getOtpSt: Status.ERROR,
          ),
        );
        event.onError();
      },
      (success) {
        event.onSuccess();
        emit(
          state.copyWith(
            getOtpSt: Status.SUCCESS,
          ),
        );
        // add(StartOtpTimerEvent(seconds));
      },
    );
  }
}
