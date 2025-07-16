// import 'package:dartz/dartz.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:axy_driver/core/error/failure.dart';
// import 'package:axy_driver/core/usecase/usecase.dart';
// import 'package:axy_driver/features/common/domain/repositories/auth.dart';
// import 'package:dartz/dartz.dart';
//
//
// part 'login_usecase.freezed.dart';
// part 'login_usecase.g.dart';
//
//
// class LoginUseCase extends UseCase<String, LoginParams> {
//   final IAuthRepository _repo;
//
//   LoginUseCase(this._repo);
//
//   @override
//   Future<Either<Failure, String>> call(LoginParams params) {
//     return _repo.login(password: params.password, username: params.username);
//   }
// }
//
// @freezed
// class LoginParams with _$LoginParams {
//   const factory LoginParams({
//     required String username,
//     required String password,
//   }) = _LoginParams;
//
//   factory LoginParams.fromJson(Map<String, dynamic> json) =>
//       _$LoginParamsFromJson(json);
// }
