part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.status = Status.UNKNOWN,
    this.failure = const UnknownFailure(),
    this.language = 'uz',
    this.onBoard = false,
    this.themeMode = ThemeModeState.light,
  });

  final Status status;
  final Failure failure;
  final String language;
  final bool onBoard;
  final ThemeModeState themeMode;

  SettingsState copyWith({
    Status? status,
    Failure? failure,
    String? language,
    bool? onBoard,
    ThemeModeState? themeMode,
  }) {
    return SettingsState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      language: language ?? this.language,
      onBoard: onBoard ?? this.onBoard,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object> get props => [status, failure, language, onBoard, themeMode];
}
