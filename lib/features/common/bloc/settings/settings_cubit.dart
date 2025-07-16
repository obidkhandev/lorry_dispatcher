import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:lorry_dispatcher/core/usecases/use_case.dart';
import 'package:lorry_dispatcher/core/utills/enums.dart';
import 'package:lorry_dispatcher/core/values/app_strings.dart';
import 'package:lorry_dispatcher/features/common/data/models/shared_model.dart';
import 'package:lorry_dispatcher/features/common/domain/uscase/settings/get_app_lang.dart';
import 'package:lorry_dispatcher/features/common/domain/uscase/settings/get_app_onboard.dart';
import 'package:lorry_dispatcher/features/common/domain/uscase/settings/save_app_onboard.dart';
import 'package:lorry_dispatcher/features/common/domain/uscase/settings/set_app_lang.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._getAppLangUseCase, this._setAppLangUseCase,
      this._getAppOnboardUseCase, this._setAppOnboardUseCase, this._preferences)
      : super(const SettingsState());

  final GetAppLangUseCase _getAppLangUseCase;
  final GetAppOnboardUseCase _getAppOnboardUseCase;
  final SetAppOnboardUseCase _setAppOnboardUseCase;
  final SetAppLangUseCase _setAppLangUseCase;
  final SharedPreferences _preferences;


  Future<void> loadTheme() async {
    final themeString = _preferences.getString(SharedModel.themeMode);

    ThemeModeState mode = ThemeModeState.auto;

    if (themeString != null) {
      mode = ThemeModeState.values.firstWhere(
            (e) => e.name == themeString,
        orElse: () => ThemeModeState.auto,
      );
    }

    if (mode == ThemeModeState.auto) {
      // Get the system's brightness (light or dark mode)
      final isSystemDark = SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
      emit(state.copyWith(
        themeMode: isSystemDark ? ThemeModeState.dark : ThemeModeState.light,
      ));
    } else {
      emit(state.copyWith(themeMode: mode));
    }
  }

  Future<void> setThemeMode(ThemeModeState mode) async {
    await _preferences.setString(SharedModel.themeMode, mode.name);
    await loadTheme();
    emit(state.copyWith(themeMode: mode));
  }

  void loadAppLang() async {
    emit(state.copyWith(status: Status.LOADING));
    var result = await _getAppLangUseCase.call(NoParams());
    result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: Status.ERROR)),
        (lang) => emit(state.copyWith(language: lang, status: Status.UNKNOWN)));
  }

  void loadAppOnboard() async {
    emit(state.copyWith(status: Status.LOADING));
    var result = await _getAppOnboardUseCase.call(NoParams());
    result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: Status.ERROR)),
        (lang) => emit(state.copyWith(onBoard: lang, status: Status.UNKNOWN)));
  }

  void saveAppLang(String lang) async {
    if (isClosed) return; // Exit if the cubit is already closed

    emit(state.copyWith(status: Status.LOADING));

    var result = await _setAppLangUseCase.call(AppLangParam(lang));
    if (isClosed) {
      return; // Check again if cubit is closed after async operation
    }

    result.fold(
      (failure) => emit(state.copyWith(failure: failure, status: Status.ERROR)),
      (lang) => emit(state.copyWith(language: lang, status: Status.UNKNOWN)),
    );
  }

  void saveAppOnboard(bool onBoard) async {
    emit(state.copyWith(status: Status.LOADING));
    var result = await _setAppOnboardUseCase.call(AppOnboardParam(onBoard));
    result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: Status.ERROR)),
        (lang) => emit(state.copyWith(onBoard: lang, status: Status.UNKNOWN)));
  }
}
