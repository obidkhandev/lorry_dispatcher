import 'package:dartz/dartz.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:lorry_dispatcher/features/profile/data/datasource/profile_datasource.dart';
import 'package:lorry_dispatcher/features/profile/data/models/response/profile_response_model.dart';
import 'package:lorry_dispatcher/features/profile/domain/repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDatasource datasource;

  ProfileRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, ProfileResponseModel>> getProfile() async {
    final response = await datasource.getProfile();
    return response.fold((failure) => Left(failure), (response) async {
      return Right(response);
    });
  }
}
