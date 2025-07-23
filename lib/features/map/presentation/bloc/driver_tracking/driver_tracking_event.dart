import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google; // Alias to avoid conflicts

abstract class DriverTrackingEvent extends Equatable {
  const DriverTrackingEvent();

  @override
  List<Object?> get props => [];
}

class InitializeTracking extends DriverTrackingEvent {
  final google.LatLng? startPoint;
  final google.LatLng? endPoint;

  InitializeTracking({required this.startPoint, required this.endPoint});

  @override
  List<Object?> get props => [startPoint, endPoint];
}

class StartLocationSimulation extends DriverTrackingEvent {}

class StopLocationSimulation extends DriverTrackingEvent {}

class ResetSimulation extends DriverTrackingEvent {}

class UpdateDriverPosition extends DriverTrackingEvent {}

class SetMapController extends DriverTrackingEvent {
  final google.GoogleMapController controller;

  const SetMapController(this.controller);

  @override
  List<Object?> get props => [controller];
}

class CenterOnDriver extends DriverTrackingEvent {}

class ShowFullRoute extends DriverTrackingEvent {}