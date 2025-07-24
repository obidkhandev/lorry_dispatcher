// create_order_state.dart
part of 'create_order_bloc.dart';

class CreateOrderState {
  final List<CountryRegionModel> pickUpAddress;
  final List<CountryRegionModel> dropOffAddress;

  const CreateOrderState({
    this.pickUpAddress = const [],
    this.dropOffAddress = const [],
  });

  CreateOrderState copyWith({
    List<CountryRegionModel>? pickUpAddress,
    List<CountryRegionModel>? dropOffAddress,
  }) {
    return CreateOrderState(
      pickUpAddress: pickUpAddress ?? this.pickUpAddress,
      dropOffAddress: dropOffAddress ?? this.dropOffAddress,
    );
  }
}