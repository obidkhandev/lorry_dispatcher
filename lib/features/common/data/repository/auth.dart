//
// import 'package:axy_driver/core/api/list_api.dart';
// import 'package:axy_driver/core/error/failure.dart';
// import 'package:axy_driver/features/common/domain/repositories/auth.dart' show IAuthRepository;
// import 'package:dartz/dartz.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class AuthRepository implements IAuthRepository {
//   final SharedPreferences _preferences;
//   // final LoginDataS/**/ources _dataSources;
//   AuthRepository(this._preferences,);
//
//
//   // @override
//   // Future<Either<Failure, String>> login({required String username, required String password}) async {
//   //   final response = await _dataSources.login(username: username, password: password);
//   //   return response.fold(
//   //         (failure) => Left(failure),
//   //         (response) async {
//   //       return Right(response);
//   //     },
//   //   );
//   // }
//
//   @override
//   Future<Either<Failure, bool>> checkUserToAuth() async {
//     try {
//       String token = _preferences.getString(ListAPI.ACCESS_TOKEN) ?? '';
//       return Right(token.isNotEmpty);
//     } catch (e) {
//       return const Left(CacheFailure());
//     }
//   }
//
//   @override
//   Future<Either<Failure, bool>> logout() async {
//     try {
//       await _preferences.setString(ListAPI.ACCESS_TOKEN, '');
//       return const Right(true);
//     } catch (e) {
//       return const Left(CacheFailure());
//     }
//   }
// }
