import 'package:dartz/dartz.dart';
import 'package:lorry_dispatcher/core/api/api.dart';
import 'package:lorry_dispatcher/core/api/handle_request.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';

abstract class AuthDatasource {
  Future<Either<Failure, String>> getOtp(String phone);
}

class AuthDatasourceImpl extends AuthDatasource {
  final DioClient dioClient;

  AuthDatasourceImpl(this.dioClient);

  @override
  Future<Either<Failure, String>> getOtp(String phone) async {
    return handleRequest(
      endpoint: ListAPI.getOtp,
      dioClient: dioClient,
      method: HttpMethod.POST,
      expectedStatusCode: 200,
      data: {
        "phone":phone,
      },
      onSuccess: (res) async {
        return res.data['code'];
      },
    );
  }


}
