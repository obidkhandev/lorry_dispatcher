import 'package:lorry_dispatcher/features/create_order/data/models/location_item_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

abstract class MapEvent {}

class InitializeMapEvent extends MapEvent {
  final YandexMapController controller;

  InitializeMapEvent(this.controller);
}

class GetUserLocationEvent extends MapEvent {}

class ZoomInEvent extends MapEvent {}

class ZoomOutEvent extends MapEvent {}

class SearchByQueryEvent extends MapEvent {
  final String query;

  SearchByQueryEvent(this.query);
}

class SearchByPointEvent extends MapEvent {
  final Point point;
  final Function(String text) onSuccess;

  SearchByPointEvent({
    required this.point,
    required this.onSuccess,
  });
}

class UpdateCameraPositionEvent extends MapEvent {
  final double latitude;
  final double longitude;
  final double zoom;

  UpdateCameraPositionEvent({
    required this.latitude,
    required this.longitude,
    required this.zoom,
  });
}


class AddSelectedLocationMarkerEvent extends MapEvent {
  final LocationItemModel location;

  AddSelectedLocationMarkerEvent({required this.location});


}

class RemoveSelectedLocationMarkerEvent extends MapEvent {


}