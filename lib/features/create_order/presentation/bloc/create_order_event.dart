part of 'create_order_bloc.dart';

abstract class CreateOrderEvent {}

// Pickup location events
class AddPickupLocationEvent extends CreateOrderEvent {
  final CountryRegionModel location;

  AddPickupLocationEvent(this.location);
}

class EditPickupLocationEvent extends CreateOrderEvent {
  final int index;
  final CountryRegionModel updatedLocation;

  EditPickupLocationEvent(this.index, this.updatedLocation);
}

class DeletePickupLocationEvent extends CreateOrderEvent {
  final int index;

  DeletePickupLocationEvent(this.index);
}

// Dropoff location events
class AddDropoffLocationEvent extends CreateOrderEvent {
  final CountryRegionModel location;

  AddDropoffLocationEvent(this.location);
}

class EditDropoffLocationEvent extends CreateOrderEvent {
  final int index;
  final CountryRegionModel updatedLocation;

  EditDropoffLocationEvent(this.index, this.updatedLocation);
}

class DeleteDropoffLocationEvent extends CreateOrderEvent {
  final int index;

  DeleteDropoffLocationEvent(this.index);
}

// Reset/Clear events
class ClearAllLocationsEvent extends CreateOrderEvent {}

class ResetCreateOrderEvent extends CreateOrderEvent {}
