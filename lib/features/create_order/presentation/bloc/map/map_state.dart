import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final double latitude;
  final double longitude;
  final double zoom;
  final bool isInitialized;
  final GoogleMapController? controller;
  final bool isLoading;
  final String? error;
  final bool isUserLocation;
  final Set<Marker> markers; // Yangi xususiyat

  const MapState({
    required this.latitude,
    required this.longitude,
    required this.zoom,
    this.isInitialized = false,
    this.controller,
    this.isLoading = false,
    this.error,
    this.isUserLocation = false,
    this.markers = const {}, // Default bo'sh markerlar to'plami
  });

  MapState copyWith({
    double? latitude,
    double? longitude,
    double? zoom,
    bool? isInitialized,
    GoogleMapController? controller,
    bool? isLoading,
    String? error,
    bool? isUserLocation,
    Set<Marker>? markers,
  }) {
    return MapState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      zoom: zoom ?? this.zoom,
      isInitialized: isInitialized ?? this.isInitialized,
      controller: controller ?? this.controller,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isUserLocation: isUserLocation ?? this.isUserLocation,
      markers: markers ?? this.markers,
    );
  }
}