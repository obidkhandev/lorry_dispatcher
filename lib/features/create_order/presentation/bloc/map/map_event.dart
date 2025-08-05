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

class SearchByPointEvent extends MapEvent {}

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
