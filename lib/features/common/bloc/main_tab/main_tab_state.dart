part of 'main_tab_cubit.dart';

@freezed
abstract class MainTabState with _$MainTabState {
  const factory MainTabState({
    @Default(1) int main,

  }) = _MainTabState;
}
