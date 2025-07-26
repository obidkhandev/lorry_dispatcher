import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:lorry_dispatcher/features/common/data/models/shared_model.dart';
import 'package:lorry_dispatcher/features/common/domain/repository/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingRepository extends ISettingRepository {
  final SharedPreferences _preferences;
  SettingRepository(this._preferences);

  @override
  Future<Either<Failure, String>> getAppLang() async {
    try {
      String lang = _preferences.getString(SharedModel.appLang) ?? 'uz';
      return Right(lang);
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      if (e.error is SocketException) {
        return const Left(ConnectionFailure());
      }
      return Left(
        (e.response?.statusCode == 401)
            ? const UnauthorizedFailure()
            : ServerFailure(),
      );
    } on Object catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> setAppLang(String lang) async {
    try {
      await _preferences.setString(SharedModel.appLang, lang);
      return Right(lang);
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      if (e.error is SocketException) {
        return const Left(ConnectionFailure());
      }
      return Left(
        (e.response?.statusCode == 401)
            ? const UnauthorizedFailure()
            : ServerFailure(),
      );
    } on Object catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, bool>> getOnBoarding() async {
    try {
      bool lang = _preferences.getBool(SharedModel.onBoard) ?? false;
      return Right(lang);
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      if (e.error is SocketException) {
        return const Left(ConnectionFailure());
      }
      return Left(
        (e.response?.statusCode == 401)
            ? const UnauthorizedFailure()
            : ServerFailure(),
      );
    } on Object catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, bool>> setOnBoarding(bool onBoard) async {
    try {
      await _preferences.setBool(SharedModel.onBoard, onBoard);
      return Right(onBoard);
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      if (e.error is SocketException) {
        return const Left(ConnectionFailure());
      }
      return Left(
        (e.response?.statusCode == 401)
            ? const UnauthorizedFailure()
            : ServerFailure(),
      );
    } on Object catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      rethrow;
    }
  }
}
