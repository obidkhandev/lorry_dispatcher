import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lorry_dispatcher/core/values/app_strings.dart';
import 'package:lorry_dispatcher/features/profile/domain/profile_repository.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:lorry_dispatcher/features/profile/data/models/response/profile_response_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository}) : super(ProfileState()) {
    on<GetProfileEvent>(_onGetProfileRequested);
  }

  Future<void> _onGetProfileRequested(
      GetProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(getProfileStatus: Status.LOADING));
    final response = await profileRepository.getProfile();
    response.fold(
          (failure) {
        emit(state.copyWith(
          getProfileStatus: Status.ERROR,
          getProfileFailure: failure,
        ));
      },
          (profile) {
        emit(state.copyWith(
          getProfileStatus: Status.SUCCESS,
          profile: profile,
        ));
      },
    );
  }
}