import 'package:dartz/dartz.dart';
import 'package:lorry_dispatcher/core/api/api.dart';
import 'package:lorry_dispatcher/core/api/handle_request.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:lorry_dispatcher/features/profile/data/models/response/profile_response_model.dart';

abstract class ProfileDatasource{

  Future<Either<Failure, ProfileResponseModel>> getProfile();
}

class ProfileDatasourceImpl extends ProfileDatasource{

  final DioClient dioClient;

  ProfileDatasourceImpl(this.dioClient);

  @override
  Future<Either<Failure, ProfileResponseModel>> getProfile() async {
    return handleRequest(
      endpoint: ListAPI.profile,
      dioClient: dioClient,
      method: HttpMethod.GET,
      expectedStatusCode: 200,
      onSuccess: (res) async {
        return ProfileResponseModel.fromJson(res.data);
      },
    );
  }
}