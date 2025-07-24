import 'package:bloc/bloc.dart';
import 'package:lorry_dispatcher/features/create_order/data/models/country_region_model.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc() : super(const CreateOrderState()) {

    // Pickup location handlers
    on<AddPickupLocationEvent>(_onAddPickupLocation);
    on<EditPickupLocationEvent>(_onEditPickupLocation);
    on<DeletePickupLocationEvent>(_onDeletePickupLocation);

    // Dropoff location handlers
    on<AddDropoffLocationEvent>(_onAddDropoffLocation);
    on<EditDropoffLocationEvent>(_onEditDropoffLocation);
    on<DeleteDropoffLocationEvent>(_onDeleteDropoffLocation);

    // Utility handlers
    on<ClearAllLocationsEvent>(_onClearAllLocations);
    on<ResetCreateOrderEvent>(_onResetCreateOrder);
  }

  // Pickup location event handlers
  void _onAddPickupLocation(
      AddPickupLocationEvent event,
      Emitter<CreateOrderState> emit,
      ) {
    final updatedPickupList = List<CountryRegionModel>.from(state.pickUpAddress)
      ..add(event.location);

    emit(state.copyWith(pickUpAddress: updatedPickupList));
  }

  void _onEditPickupLocation(
      EditPickupLocationEvent event,
      Emitter<CreateOrderState> emit,
      ) {
    if (event.index >= 0 && event.index < state.pickUpAddress.length) {
      final updatedPickupList = List<CountryRegionModel>.from(state.pickUpAddress);
      updatedPickupList[event.index] = event.updatedLocation;

      emit(state.copyWith(pickUpAddress: updatedPickupList));
    }
  }

  void _onDeletePickupLocation(
      DeletePickupLocationEvent event,
      Emitter<CreateOrderState> emit,
      ) {
    if (event.index >= 0 && event.index < state.pickUpAddress.length) {
      final updatedPickupList = List<CountryRegionModel>.from(state.pickUpAddress)
        ..removeAt(event.index);

      emit(state.copyWith(pickUpAddress: updatedPickupList));
    }
  }

  // Dropoff location event handlers
  void _onAddDropoffLocation(
      AddDropoffLocationEvent event,
      Emitter<CreateOrderState> emit,
      ) {
    final updatedDropoffList = List<CountryRegionModel>.from(state.dropOffAddress)
      ..add(event.location);

    emit(state.copyWith(dropOffAddress: updatedDropoffList));
  }

  void _onEditDropoffLocation(
      EditDropoffLocationEvent event,
      Emitter<CreateOrderState> emit,
      ) {
    if (event.index >= 0 && event.index < state.dropOffAddress.length) {
      final updatedDropoffList = List<CountryRegionModel>.from(state.dropOffAddress);
      updatedDropoffList[event.index] = event.updatedLocation;

      emit(state.copyWith(dropOffAddress: updatedDropoffList));
    }
  }

  void _onDeleteDropoffLocation(
      DeleteDropoffLocationEvent event,
      Emitter<CreateOrderState> emit,
      ) {
    if (event.index >= 0 && event.index < state.dropOffAddress.length) {
      final updatedDropoffList = List<CountryRegionModel>.from(state.dropOffAddress)
        ..removeAt(event.index);

      emit(state.copyWith(dropOffAddress: updatedDropoffList));
    }
  }

  // Utility event handlers
  void _onClearAllLocations(
      ClearAllLocationsEvent event,
      Emitter<CreateOrderState> emit,
      ) {
    emit(const CreateOrderState());
  }

  void _onResetCreateOrder(
      ResetCreateOrderEvent event,
      Emitter<CreateOrderState> emit,
      ) {
    emit(const CreateOrderState());
  }
}