import 'package:dartz/dartz.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';

abstract class IAuthRepository {
  Future<Either<Failure, bool>> checkUserToAuth();
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, String>> getOtp(String phone);
  Future<Either<Failure, String>> otpVerifyCode({
    required String code,
    required String phone,
    required int role,
  });

}
