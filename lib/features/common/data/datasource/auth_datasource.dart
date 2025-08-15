import 'package:dartz/dartz.dart';
import 'package:lorry_dispatcher/core/api/api.dart';
import 'package:lorry_dispatcher/core/api/handle_request.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDatasource {
  Future<Either<Failure, String>> getOtp(String phone);

  Future<Either<Failure, String>> otpVerifyCode({
    required String code,
    required String phone,
    required int role,
  });
}

class AuthDatasourceImpl extends AuthDatasource {
  final DioClient dioClient;
  final SharedPreferences _preferences;

  AuthDatasourceImpl(this.dioClient, this._preferences);

  @override
  Future<Either<Failure, String>> getOtp(String phone) async {
    return handleRequest(
      endpoint: ListAPI.getOtp,
      dioClient: dioClient,
      method: HttpMethod.POST,
      expectedStatusCode: 200,
      data: {"phone": phone},
      onSuccess: (res) async {
        return res.data['code'];
      },
    );
  }

  @override
  Future<Either<Failure, String>> otpVerifyCode({
    required String code,
    required String phone,
    required int role,
  }) async {
    return handleRequest(
      endpoint: ListAPI.otpVerify,
      dioClient: dioClient,
      method: HttpMethod.POST,
      expectedStatusCode: 200,
      data: {"code": code, "phone": phone, "role": role},
      onSuccess: (res) async {
        final data = res.data;
        await _preferences.setString(ListAPI.accessToken, data['access']);
        await _preferences.setInt(ListAPI.userId, data['user_id']);
        return "success";
      },
    );
  }
}
