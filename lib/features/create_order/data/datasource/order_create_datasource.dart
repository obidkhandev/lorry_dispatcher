import 'package:lorry_dispatcher/core/api/api.dart';

abstract class OrderCreateDatasource{

}

class OrderCreateDatasourceImpl extends OrderCreateDatasource{
  final DioClient dioClient;

  OrderCreateDatasourceImpl(this.dioClient);
}