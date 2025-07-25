import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_event.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_state.dart';
import 'package:permission_handler/permission_handler.dart';

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
  }

  void _onInitializeMap(InitializeMapEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isInitialized: true, controller: event.controller));
    add(GetUserLocationEvent());
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

      // Marker yaratish
      final marker = Marker(
        markerId: const MarkerId('user_location'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );

      emit(
        state.copyWith(
          latitude: position.latitude,
          longitude: position.longitude,
          zoom: 17.0,
          isLoading: false,
          isUserLocation: true,
          error: null,
          markers: {marker}, // Markerlarni yangilash
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
      animateToPosition(state.latitude, state.longitude, newZoom);
      emit(state.copyWith(zoom: newZoom));
    }
  }


  void animateToPosition(double latitude, double longitude, double zoom) {
    if (state.controller != null) {
      state.controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: zoom,
          ),
        ),
      );
    }
  }

  void _onZoomOut(ZoomOutEvent event, Emitter<MapState> emit) {
    if (state.zoom > 2.0) {
      final newZoom = state.zoom - 1.0;
      animateToPosition(state.latitude, state.longitude, newZoom);
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
        isUserLocation: false, // Clear user location flag when manually moving
      ),
    );
  }
}
