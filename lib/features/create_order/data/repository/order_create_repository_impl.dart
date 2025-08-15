import 'package:lorry_dispatcher/features/create_order/data/datasource/order_create_datasource.dart';
import 'package:lorry_dispatcher/features/create_order/domain/repository/order_create_repository.dart';

class OrderCreateRepositoryImpl extends OrderCreateRepository{
  final OrderCreateDatasource _datasource;

  OrderCreateRepositoryImpl(this._datasource);
}