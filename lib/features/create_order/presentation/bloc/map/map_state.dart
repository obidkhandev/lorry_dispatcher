import 'package:lorry_dispatcher/features/create_order/data/models/location_item_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapState {
  final double latitude;
  final double longitude;
  final double zoom;
  final bool isInitialized;
  final YandexMapController? controller;
  final bool isLoading;
  final String? error;
  final bool isUserLocation;
  final List<SuggestItem> suggestionItem;
  final String? currentLocationName;
  final List<PlacemarkMapObject> placemarks;
  final LocationItemModel? selectedLocation;

  const MapState({
    required this.latitude,
    required this.longitude,
    required this.zoom,
    this.isInitialized = false,
    this.controller,
    this.isLoading = false,
    this.error,
    this.currentLocationName = '',
    this.suggestionItem = const [],
    this.placemarks = const [],
    this.isUserLocation = false,
    this.selectedLocation,
  });

  MapState copyWith({
    double? latitude,
    double? longitude,
    double? zoom,
    bool? isInitialized,
    YandexMapController? controller,
    bool? isLoading,
    String? error,
    bool? isUserLocation,
    List<SuggestItem>? suggestionItem,
    String? currentLocationName,
    List<PlacemarkMapObject>? placemarks,
    LocationItemModel? selectedLocation,
  }) {
    return MapState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      zoom: zoom ?? this.zoom,
      isInitialized: isInitialized ?? this.isInitialized,
      controller: controller ?? this.controller,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      suggestionItem: suggestionItem ?? this.suggestionItem,
      currentLocationName: currentLocationName ?? this.currentLocationName,
      isUserLocation: isUserLocation ?? this.isUserLocation,
      placemarks: placemarks ?? this.placemarks,
      selectedLocation: selectedLocation ?? this.selectedLocation,
    );
  }
}
