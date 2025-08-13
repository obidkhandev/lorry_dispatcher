import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lorry_dispatcher/core/services/location/location_service.dart';
import 'package:lorry_dispatcher/core/values/app_assets.dart';
import 'package:lorry_dispatcher/core/values/app_icons.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_event.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_state.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc()
    : super(
        const MapState(latitude: 41.311081, longitude: 69.240562, zoom: 15.0),
      ) {
    on<InitializeMapEvent>(_onInitializeMap);
    on<GetUserLocationEvent>(_onGetUserLocation);
    on<ZoomInEvent>(_onZoomIn);
    on<ZoomOutEvent>(_onZoomOut);
    on<UpdateCameraPositionEvent>(_onUpdateCameraPosition);
    on<SearchByQueryEvent>(_searchByQuery);
    on<SearchByPointEvent>(_searchByPoint);
    on<AddSelectedLocationMarkerEvent>(_onAddSelectedLocationMarker);
    on<RemoveSelectedLocationMarkerEvent>(_onRemoveSelectedLocationMarker);
  }

  void _onInitializeMap(InitializeMapEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isInitialized: true, controller: event.controller));
    add(GetUserLocationEvent());
  }

  Future<void> _onAddSelectedLocationMarker(
    AddSelectedLocationMarkerEvent event,
    Emitter<MapState> emit,
  ) async {
    animateToPosition(event.location.latitude, event.location.longitude, 15);

    emit(
      state.copyWith(
        selectedLocation: event.location,
      ),
    );
  }

  void _onRemoveSelectedLocationMarker(
    RemoveSelectedLocationMarkerEvent event,
    Emitter<MapState> emit,
  ) {
    emit(state.copyWith(selectedLocation: null,));
  }

  /// Get placemark objects for the map
  Future<PlacemarkMapObject> getPlacemarkObjects(
    Point point,
    String icon,
  ) async {
    final Uint8List buildingIconBytes = await _loadBuildingIcon(icon);

    final placemark = PlacemarkMapObject(
      mapId: MapObjectId('MapObject_${point.longitude}_${point.latitude}'),
      point: Point(latitude: point.latitude, longitude: point.longitude),
      opacity: 1,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromBytes(buildingIconBytes),
          rotationType: RotationType.rotate,
          scale: 0.7,
        ),
      ),
    );
    return placemark;
  }

  /// Load the building icon from assets
  Future<Uint8List> _loadBuildingIcon(String iconSvg) async {
    try {
      final ByteData data = await rootBundle.load(
        iconSvg,
      ); // Ensure the correct path is provided here
      return data.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error loading building icon: $e');
      return Uint8List(0); // Return empty list in case of error
    }
  }

  Future<void> _searchByQuery(
    SearchByQueryEvent event,
    Emitter<MapState> emit,
  ) async {
    try {
      // Emit loading state
      emit(state.copyWith(isLoading: true, error: null));

      final response = YandexSuggest.getSuggestions(
        text: event.query,
        boundingBox: BoundingBox(
          northEast: Point(latitude: 55.75, longitude: 37.55),
          southWest: Point(latitude: 55.65, longitude: 37.65),
        ),
        suggestOptions: const SuggestOptions(
          suggestType: SuggestType.unspecified,
          // Use geo for location-based suggestions
          suggestWords: true,
        ),
      );

      await response.result.then((values) {
        if (values.items != null && values.items!.isNotEmpty) {
          print("location search ${values.items?.first.title}");
          print("location search ${values.items?.first.displayText}");
          print("location search ${values.items?.first.subtitle}");
          print("location search ${values.items?.first.tags}");
          print("location search ${values.items?.first.type}");
          print("location search ${values.items?.first.props}");
          emit(state.copyWith(isLoading: false, suggestionItem: values.items));
        } else {
          // No suggestions found
          emit(
            state.copyWith(
              isLoading: false,
              error: 'No suggestions found for the query',
            ),
          );
        }
      });
    } catch (e) {
      print("error: $e");
      // Handle any errors (e.g., network issues)
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Search failed: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _searchByPoint(
    SearchByPointEvent event,
    Emitter<MapState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final response = YandexSearch.searchByPoint(
        point: event.point,

        searchOptions: const SearchOptions(searchType: SearchType.none),
      );

      await response.result.then((values) {
        if (values.items != null && values.items!.isNotEmpty) {
          emit(
            state.copyWith(
              isLoading: false,
              currentLocationName: values.items?.first.name,
            ),
          );
          event.onSuccess(values.items?.first.name ?? '');
        } else {
          // No suggestions found
          emit(
            state.copyWith(
              isLoading: false,
              error: 'No suggestions found for the query',
            ),
          );
        }
      });
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Search failed: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onGetUserLocation(
    GetUserLocationEvent event,
    Emitter<MapState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(
          state.copyWith(
            isLoading: false,
            error: 'Location services are disabled',
          ),
        );
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      animateToPosition(position.latitude, position.longitude, 16);

      emit(
        state.copyWith(
          latitude: position.latitude,
          longitude: position.longitude,
          zoom: 17.0,
          isLoading: false,
          isUserLocation: true,
          error: null,
          // markers: {marker}, // Markerlarni yangilash
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to get location: ${e.toString()}',
        ),
      );
    }
  }

  void _onZoomIn(ZoomInEvent event, Emitter<MapState> emit) {
    if (state.zoom < 20.0) {
      final newZoom = state.zoom + 1.0;
      state.controller!.moveCamera(CameraUpdate.zoomIn());
      emit(state.copyWith(zoom: newZoom));
    }
  }

  void animateToPosition(double latitude, double longitude, double zoom) {
    if (state.controller != null) {
      state.controller!.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(latitude: latitude, longitude: longitude),
            zoom: zoom,
          ),
        ),
      );
    }
  }

  void _onZoomOut(ZoomOutEvent event, Emitter<MapState> emit) {
    if (state.zoom > 2.0) {
      final newZoom = state.zoom - 1.0;
      state.controller!.moveCamera(CameraUpdate.zoomOut());
      emit(state.copyWith(zoom: newZoom));
    }
  }

  void _onUpdateCameraPosition(
    UpdateCameraPositionEvent event,
    Emitter<MapState> emit,
  ) {
    emit(
      state.copyWith(
        latitude: event.latitude,
        longitude: event.longitude,
        zoom: event.zoom,
        isUserLocation: false,
      ),
    );
  }
}
