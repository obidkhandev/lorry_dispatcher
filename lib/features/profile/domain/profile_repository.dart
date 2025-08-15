import 'package:dartz/dartz.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:lorry_dispatcher/features/profile/data/models/response/profile_response_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileResponseModel>> getProfile();
}
