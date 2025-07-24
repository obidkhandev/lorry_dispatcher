import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google; // Alias to avoid conflicts
import 'package:lorry_dispatcher/core/api/api.dart';
import 'package:lorry_dispatcher/features/map/presentation/bloc/driver_tracking/driver_tracking_event.dart';
import 'package:lorry_dispatcher/features/map/presentation/bloc/driver_tracking/driver_tracking_state.dart';

class DriverTrackingBloc extends Bloc<DriverTrackingEvent, DriverTrackingState> {
  Timer? _locationTimer;
  static const Duration _updateInterval = Duration(milliseconds: 1000);
  static const double _progressIncrement = 0.05;

  DriverTrackingBloc() : super(const DriverTrackingState()) {
    on<InitializeTracking>(_onInitializeTracking);
    on<StartLocationSimulation>(_onStartLocationSimulation);
    on<StopLocationSimulation>(_onStopLocationSimulation);
    on<ResetSimulation>(_onResetSimulation);
    on<UpdateDriverPosition>(_onUpdateDriverPosition);
    on<SetMapController>(_onSetMapController);
    on<CenterOnDriver>(_onCenterOnDriver);
    on<ShowFullRoute>(_onShowFullRoute);
  }

  @override
  Future<void> close() {
    _locationTimer?.cancel();
    return super.close();
  }

  Future<void> _onInitializeTracking(
      InitializeTracking event,
      Emitter<DriverTrackingState> emit,
      ) async {
    try {
      emit(state.copyWith(status: TrackingStatus.loading));

      final routePoints = await _fetchRoutePoints(
        event.startPoint ?? google.LatLng(41.2995, 69.2401),
        event.endPoint ?? google.LatLng(41.3000, 69.3100),
      );

      if (routePoints.isEmpty) {
        emit(state.copyWith(
          status: TrackingStatus.error,
          errorMessage: 'No route points retrieved from Google Directions API',
        ));
        return;
      }

      final startIcon = await _createStartIcon();
      final endIcon = await _createEndIcon();
      final driverIcon = await _createDriverIcon();

      final currentDriverPosition = routePoints.first;

      emit(state.copyWith(
        status: TrackingStatus.idle,
        routePoints: routePoints,
        currentDriverPosition: currentDriverPosition,
        driverPath: [currentDriverPosition],
        currentPointIndex: 0,
        routeProgress: 0.0,
        startIcon: startIcon,
        endIcon: endIcon,
        driverIcon: driverIcon,
        iconsInitialized: true,
      ));

      if (state.mapController != null) {
        await _setupMapObjects(emit);
      }
    } catch (e) {
      emit(state.copyWith(
        status: TrackingStatus.error,
        errorMessage: 'Initialization failed: $e',
      ));
    }
  }

  Future<List<google.LatLng>> _fetchRoutePoints(google.LatLng start, google.LatLng end) async {
    final polylinePoints = PolylinePoints(apiKey: ListAPI.googleDirectionApi);

    try {
      final result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: PointLatLng(start.latitude, start.longitude),
          destination: PointLatLng(end.latitude, end.longitude),
          mode: TravelMode.driving,
        ),
      );

      print('API Response Status: ${result.status}');
      print('API Response Points: ${result.points.length}');

      if (result.status == 'OK' && result.points.isNotEmpty) {
        return result.points
            .map((point) => google.LatLng(point.latitude, point.longitude))
            .toList();
      } else {
        print('API Error: ${result.status} - ${result.errorMessage}');
        return [];
      }
    } catch (e) {
      print('Fetch error: $e');
      return [];
    }
  }

  Future<void> _onSetMapController(
      SetMapController event,
      Emitter<DriverTrackingState> emit,
      ) async {
    emit(state.copyWith(mapController: event.controller));
    if (state.iconsInitialized && state.routePoints.isNotEmpty) {
      await _setupMapObjects(emit);
    }
  }

  Future<void> _setupMapObjects(Emitter<DriverTrackingState> emit) async {
    if (!state.iconsInitialized || state.routePoints.isEmpty || state.currentDriverPosition == null) {
      return;
    }

    final placemarks = <String, google.Marker>{}; // Changed to Marker
    final polylines = <String, google.Polyline>{}; // Changed to Polyline

    placemarks['start'] = google.Marker(
      markerId: const google.MarkerId('start_point'),
      position: state.routePoints.first,
      icon: google.BitmapDescriptor.fromBytes(state.startIcon!),
      infoWindow: const google.InfoWindow(title: 'Start'),
    );

    placemarks['end'] = google.Marker(
      markerId: const google.MarkerId('end_point'),
      position: state.routePoints.last,
      icon: google.BitmapDescriptor.fromBytes(state.endIcon!),
      infoWindow: const google.InfoWindow(title: 'End'),
    );

    placemarks['driver'] = google.Marker(
      markerId: const google.MarkerId('driver'),
      position: state.currentDriverPosition!,
      icon: google.BitmapDescriptor.fromBytes(state.driverIcon!),
      rotation: _calculateBearing(state.currentDriverPosition!, state.routePoints[state.currentPointIndex + 1]),
    );

    polylines['planned_route'] = google.Polyline(
      polylineId: const google.PolylineId('planned_route'),
      points: state.routePoints,
      color: Colors.blue.withOpacity(0.5),
      width: 3,
    );

    polylines['driver_path'] = google.Polyline(
      polylineId: const google.PolylineId('driver_path'),
      points: state.driverPath,
      color: Colors.green,
      width: 4,
    );

    emit(state.copyWith(placemarks: placemarks, polylines: polylines));
  }

  void _onStartLocationSimulation(
      StartLocationSimulation event,
      Emitter<DriverTrackingState> emit,
      ) {
    if (state.status == TrackingStatus.running) return;
    emit(state.copyWith(status: TrackingStatus.running));
    _locationTimer?.cancel();
    _locationTimer = Timer.periodic(
      _updateInterval,
          (timer) => add(UpdateDriverPosition()),
    );
  }

  void _onStopLocationSimulation(
      StopLocationSimulation event,
      Emitter<DriverTrackingState> emit,
      ) {
    _locationTimer?.cancel();
    emit(state.copyWith(status: TrackingStatus.idle));
  }

  Future<void> _onUpdateDriverPosition(
      UpdateDriverPosition event,
      Emitter<DriverTrackingState> emit,
      ) async {
    if (state.currentPointIndex >= state.routePoints.length - 1) {
      _locationTimer?.cancel();
      emit(state.copyWith(status: TrackingStatus.completed));
      return;
    }

    final currentPoint = state.routePoints[state.currentPointIndex];
    final nextPoint = state.routePoints[state.currentPointIndex + 1];

    double newProgress = (state.routeProgress + _progressIncrement).clamp(0.0, 1.0);
    int newPointIndex = state.currentPointIndex;

    if (newProgress >= 1.0) {
      newProgress = 0.0;
      newPointIndex++;
    }

    final newLat = currentPoint.latitude + (nextPoint.latitude - currentPoint.latitude) * newProgress;
    final newLon = currentPoint.longitude + (nextPoint.longitude - currentPoint.longitude) * newProgress;
    final newPosition = google.LatLng(newLat, newLon);
    final updatedDriverPath = List<google.LatLng>.from(state.driverPath)..add(newPosition);

    final bearing = state.currentDriverPosition != null
        ? _calculateBearing(state.currentDriverPosition!, newPosition)
        : 0.0;

    final updatedPlacemarks = Map<String, google.Marker>.from(state.placemarks);
    if (updatedPlacemarks.containsKey('driver') && state.driverIcon != null) {
      updatedPlacemarks['driver'] = google.Marker(
        markerId: const google.MarkerId('driver'),
        position: newPosition,
        icon: google.BitmapDescriptor.fromBytes(state.driverIcon!),
        rotation: bearing,
      );
    }

    final updatedPolylines = Map<String, google.Polyline>.from(state.polylines);
    if (updatedPolylines.containsKey('driver_path')) {
      updatedPolylines['driver_path'] = google.Polyline(
        polylineId: const google.PolylineId('driver_path'),
        points: updatedDriverPath,
        color: Colors.green,
        width: 4,
      );
    }

    if (newPointIndex >= state.routePoints.length - 1 && newProgress >= 1.0) {
      _locationTimer?.cancel();
      emit(state.copyWith(
        status: TrackingStatus.completed,
        currentDriverPosition: newPosition,
        driverPath: updatedDriverPath,
        currentPointIndex: newPointIndex,
        routeProgress: newProgress,
        placemarks: updatedPlacemarks,
        polylines: updatedPolylines,
      ));
    } else {
      emit(state.copyWith(
        currentDriverPosition: newPosition,
        driverPath: updatedDriverPath,
        currentPointIndex: newPointIndex,
        routeProgress: newProgress,
        placemarks: updatedPlacemarks,
        polylines: updatedPolylines,
      ));
    }
  }

  void _onResetSimulation(
      ResetSimulation event,
      Emitter<DriverTrackingState> emit,
      ) {
    _locationTimer?.cancel();
    if (state.routePoints.isNotEmpty) {
      final currentDriverPosition = state.routePoints.first;
      emit(state.copyWith(
        status: TrackingStatus.idle,
        currentDriverPosition: currentDriverPosition,
        driverPath: [currentDriverPosition],
        currentPointIndex: 0,
        routeProgress: 0.0,
      ));
      if (state.mapController != null && state.iconsInitialized) {
        _setupMapObjects(emit);
      }
    }
  }

  void _onCenterOnDriver(
      CenterOnDriver event,
      Emitter<DriverTrackingState> emit,
      ) {
    if (state.currentDriverPosition != null && state.mapController != null) {
      state.mapController!.moveCamera(
        google.CameraUpdate.newLatLngZoom(state.currentDriverPosition!, 16),
      );
    }
  }

  void _onShowFullRoute(
      ShowFullRoute event,
      Emitter<DriverTrackingState> emit,
      ) {
    if (state.mapController != null && state.routePoints.isNotEmpty) {
      final centerLat = (state.routePoints.first.latitude + state.routePoints.last.latitude) / 2;
      final centerLon = (state.routePoints.first.longitude + state.routePoints.last.longitude) / 2;
      state.mapController!.moveCamera(
        google.CameraUpdate.newLatLngZoom(google.LatLng(centerLat, centerLon), 12),
      );
    }
  }

  double _calculateBearing(google.LatLng start, google.LatLng end) {
    final lat1Rad = start.latitude * pi / 180;
    final lat2Rad = end.latitude * pi / 180;
    final deltaLonRad = (end.longitude - start.longitude) * pi / 180;

    final y = sin(deltaLonRad) * cos(lat2Rad);
    final x = cos(lat1Rad) * sin(lat2Rad) - sin(lat1Rad) * cos(lat2Rad) * cos(deltaLonRad);
    final bearingRad = atan2(y, x);
    final bearingDeg = (bearingRad * 180 / pi + 360) % 360;

    return bearingDeg;
  }

  Future<Uint8List> _createStartIcon() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = 60.0;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(Offset(size / 2 + 2, size / 2 + 2), size / 2 - 5, shadowPaint);

    final mainPaint = Paint()..color = Colors.green..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2 - 5, mainPaint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2 - 5, borderPaint);

    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'S',
        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size / 2 - textPainter.width / 2, size / 2 - textPainter.height / 2));

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<Uint8List> _createEndIcon() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = 60.0;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(Offset(size / 2 + 2, size / 2 + 2), size / 2 - 5, shadowPaint);

    final mainPaint = Paint()..color = Colors.red..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2 - 5, mainPaint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2 - 5, borderPaint);

    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'E',
        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size / 2 - textPainter.width / 2, size / 2 - textPainter.height / 2));

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<Uint8List> _createDriverIcon() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = 50.0;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawCircle(Offset(size / 2 + 1, size / 2 + 1), size / 2 - 3, shadowPaint);

    final bgPaint = Paint()..color = Colors.blue..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2 - 3, bgPaint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2 - 3, borderPaint);

    final carPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    final carRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(size / 2, size / 2), width: size * 0.4, height: size * 0.6),
      const Radius.circular(3),
    );
    canvas.drawRRect(carRect, carPaint);

    final roofRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(size / 2, size / 2 - size * 0.08), width: size * 0.25, height: size * 0.25),
      const Radius.circular(2),
    );
    canvas.drawRRect(roofRect, carPaint);

    final arrowPaint = Paint()..color = Colors.yellow..style = PaintingStyle.fill;
    final arrowPath = Path()
      ..moveTo(size / 2, size / 2 - size * 0.25)
      ..lineTo(size / 2 - size * 0.08, size / 2 - size * 0.15)
      ..lineTo(size / 2 + size * 0.08, size / 2 - size * 0.15)
      ..close();
    canvas.drawPath(arrowPath, arrowPaint);

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}