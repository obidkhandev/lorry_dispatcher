part of 'profile_bloc.dart';

@freezed
 abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(Status.UNKNOWN) Status getProfileStatus,
    ProfileResponseModel? profile,
    @Default(UnknownFailure()) Failure? getProfileFailure,
  }) = _ProfileState;
}