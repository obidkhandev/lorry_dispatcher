// import 'package:equatable/equatable.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart' as google; // Alias to avoid conflicts
// import 'dart:typed_data';
//
// enum TrackingStatus { idle, running, completed, error, loading }
//
// class DriverTrackingState extends Equatable {
//   final TrackingStatus status;
//   final List<google.LatLng> routePoints;
//   final google.LatLng? currentDriverPosition;
//   final List<google.LatLng> driverPath;
//   final int currentPointIndex;
//   final double routeProgress;
//   final Map<String, google.Marker> placemarks; // Changed to Marker
//   final Map<String, google.Polyline> polylines; // Changed to Polyline
//   final google.GoogleMapController? mapController; // Changed to GoogleMapController
//   final Uint8List? startIcon;
//   final Uint8List? endIcon;
//   final Uint8List? driverIcon;
//   final bool iconsInitialized;
//   final String? errorMessage;
//
//   const DriverTrackingState({
//     this.status = TrackingStatus.idle,
//     this.routePoints = const [],
//     this.currentDriverPosition,
//     this.driverPath = const [],
//     this.currentPointIndex = 0,
//     this.routeProgress = 0.0,
//     this.placemarks = const {},
//     this.polylines = const {},
//     this.mapController,
//     this.startIcon,
//     this.endIcon,
//     this.driverIcon,
//     this.iconsInitialized = false,
//     this.errorMessage,
//   });
//
//   DriverTrackingState copyWith({
//     TrackingStatus? status,
//     List<google.LatLng>? routePoints,
//     google.LatLng? currentDriverPosition,
//     List<google.LatLng>? driverPath,
//     int? currentPointIndex,
//     double? routeProgress,
//     Map<String, google.Marker>? placemarks, // Changed to Marker
//     Map<String, google.Polyline>? polylines, // Changed to Polyline
//     google.GoogleMapController? mapController, // Changed to GoogleMapController
//     Uint8List? startIcon,
//     Uint8List? endIcon,
//     Uint8List? driverIcon,
//     bool? iconsInitialized,
//     String? errorMessage,
//   }) {
//     return DriverTrackingState(
//       status: status ?? this.status,
//       routePoints: routePoints ?? this.routePoints,
//       currentDriverPosition: currentDriverPosition ?? this.currentDriverPosition,
//       driverPath: driverPath ?? this.driverPath,
//       currentPointIndex: currentPointIndex ?? this.currentPointIndex,
//       routeProgress: routeProgress ?? this.routeProgress,
//       placemarks: placemarks ?? this.placemarks,
//       polylines: polylines ?? this.polylines,
//       mapController: mapController ?? this.mapController,
//       startIcon: startIcon ?? this.startIcon,
//       endIcon: endIcon ?? this.endIcon,
//       driverIcon: driverIcon ?? this.driverIcon,
//       iconsInitialized: iconsInitialized ?? this.iconsInitialized,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//     status,
//     routePoints,
//     currentDriverPosition,
//     driverPath,
//     currentPointIndex,
//     routeProgress,
//     placemarks,
//     polylines,
//     mapController,
//     startIcon,
//     endIcon,
//     driverIcon,
//     iconsInitialized,
//     errorMessage,
//   ];
// }