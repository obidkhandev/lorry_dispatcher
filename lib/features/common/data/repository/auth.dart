import 'package:dartz/dartz.dart';
import 'package:lorry_dispatcher/core/api/list_api.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:lorry_dispatcher/features/common/data/datasource/auth_datasource.dart';
import 'package:lorry_dispatcher/features/common/domain/repository/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository implements IAuthRepository {
  final SharedPreferences _preferences;
  final AuthDatasource datasource;

  AuthRepository(this._preferences, this.datasource);

  @override
  Future<Either<Failure, String>> getOtp(String phone) async {
    final response = await datasource.getOtp(phone);
    return response.fold((failure) => Left(failure), (response) async {
      return Right(response);
    });
  }

  @override
  Future<Either<Failure, String>> otpVerifyCode({
    required String code,
    required String phone,
    required int role,
  }) async {
    final response = await datasource.otpVerifyCode(
      code: code,
      phone: phone,
      role: role,
    );
    return response.fold((failure) => Left(failure), (response) async {
      return Right(response);
    });
  }

  @override
  Future<Either<Failure, bool>> checkUserToAuth() async {
    try {
      String token = _preferences.getString(ListAPI.accessToken) ?? '';
      return Right(token.isNotEmpty);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await _preferences.setString(ListAPI.accessToken, '');
      return const Right(true);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }
}
