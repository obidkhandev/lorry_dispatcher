import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvent {}

class InitializeMapEvent extends MapEvent {
  final GoogleMapController controller;

  InitializeMapEvent(this.controller);
}

class GetUserLocationEvent extends MapEvent {}

class ZoomInEvent extends MapEvent {}

class ZoomOutEvent extends MapEvent {}

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