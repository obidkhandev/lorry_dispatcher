// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lorry_dispatcher/core/services/location/cluster_painter.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_state.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'dart:math' as math;

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled.');
      throw Exception('Location services are disabled.');
    }

    // Check if the app has location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permissions are denied.');
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('Location permissions are permanently denied.');
      throw Exception('Location permissions are permanently denied.');
    }

    // Get the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      debugPrint(
        'Location obtained: ${position.latitude}, ${position.longitude}',
      );
      final t = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      debugPrint('Location obtained: ${t.first.name}');
      debugPrint('Location obtained: ${t.first.locality}');
      return position;
    } catch (e) {
      debugPrint('Failed to get location: $e');
      throw Exception('Failed to get location: $e');
    }
  }

  // Clusterized Placemark Collectionni yaratish
  ClusterizedPlacemarkCollection buildClusterizedPlacemarkCollection(
      MapState state,
      ) {
    return ClusterizedPlacemarkCollection(
      mapId: const MapObjectId('clusterized-1'),
      placemarks: state.placemarks,
      radius: 50,
      minZoom: 15,
      onClusterAdded: (self, cluster) async {
        return cluster.copyWith(
          appearance: cluster.appearance.copyWith(
            opacity: 1.0,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromBytes(
                  await ClusterIconPainter(cluster.size).getClusterIconBytes(),
                ),
                scale: 1,
              ),
            ),
          ),
        );
      },
      onClusterTap: (self, cluster) async {
        await state.controller?.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: cluster.placemarks.first.point,
              zoom: state.zoom + 1,
            ),
          ),
          animation: const MapAnimation(
            type: MapAnimationType.linear,
            duration: 0.4,
          ),
        );
      },
    );
  }

  Future<UserLocationView> onUserLocationAdded(
      UserLocationView view,
      MapState state,
      ) async {
    // получаем местоположение пользователя
    final position = await getCurrentLocation();
    // если местоположение найдено, центрируем карту относительно этой точки
    await state.controller?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 14,
          target: Point(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
        ),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.linear,
        duration: 0.3,
      ),
    );

    return view.copyWith(
      pin: view.pin.copyWith(
        opacity: 1,
      ),

      accuracyCircle: view.accuracyCircle.copyWith(
        strokeWidth: 2,
        fillColor: AppColors.primaryColor.withOpacity(0.6),
        strokeColor: AppColors.primaryColor,
      ),
    );
  }

  List<PolygonMapObject> generateHexagons(
      List<Point> points,
      double radiusMeters,
      ) {
    const earthRadius = 6371000; // Earth's radius in meters
    const sides = 6; // Hexagon has 6 sides
    final hexagons = <PolygonMapObject>[];

    for (var pointIndex = 0; pointIndex < points.length; pointIndex++) {
      final centerPoint = points[pointIndex];

      // Define hexagon positions in a hexagonal pattern
      // Center hexagon + 6 surrounding hexagons in first ring
      final hexagonOffsets = [
        // Center hexagon
        {'q': 0, 'r': 0},

        // First ring of 6 hexagons around center
        {'q': 1, 'r': 0}, // Right
        {'q': 1, 'r': -1}, // Top-right
        {'q': 0, 'r': -1}, // Top-left
        {'q': -1, 'r': 0}, // Left
        {'q': -1, 'r': 1}, // Bottom-left
        {'q': 0, 'r': 1}, // Bottom-right
      ];

      for (var hexIndex = 0; hexIndex < hexagonOffsets.length; hexIndex++) {
        final offset = hexagonOffsets[hexIndex];
        final q = offset['q']!;
        final r = offset['r']!;

        // Convert axial coordinates (q, r) to pixel coordinates
        // For touching hexagons, the distance between centers should be √3 * radius
        final hexSpacing = math.sqrt(3) * radiusMeters;
        final x = hexSpacing * (3.0 / 2.0 * q);
        final y = hexSpacing * (math.sqrt(3) / 2.0 * q + math.sqrt(3) * r);

        // Calculate the center of this hexagon
        final latOffset = (y / earthRadius) * (180 / math.pi);
        final lonOffset =
            (x / earthRadius) *
                (180 / math.pi) /
                math.cos(centerPoint.latitude * math.pi / 180);

        final hexagonCenter = Point(
          latitude: centerPoint.latitude + latOffset,
          longitude: centerPoint.longitude + lonOffset,
        );

        // Generate vertices for this hexagon
        final vertices = <Point>[];

        for (var j = 0; j < sides; j++) {
          // Start from 30 degrees to make hexagon flat-topped
          final angleDeg = 30 + (60 * j); // 60 degrees for each vertex
          final angleRad = math.pi / 180 * angleDeg;

          // Convert radius to latitude/longitude offsets for vertices
          final vertexLatOffset =
              (radiusMeters / earthRadius) * (180 / math.pi);
          final vertexLonOffset =
              (radiusMeters / earthRadius) *
                  (180 / math.pi) /
                  math.cos(hexagonCenter.latitude * math.pi / 180);

          // Calculate the vertex coordinates
          final vertexLat =
              hexagonCenter.latitude + (vertexLatOffset * math.sin(angleRad));
          final vertexLon =
              hexagonCenter.longitude + (vertexLonOffset * math.cos(angleRad));
          vertices.add(Point(latitude: vertexLat, longitude: vertexLon));
        }

        // Create a PolygonMapObject for the hexagon
        final hexagon = PolygonMapObject(
          mapId: MapObjectId('hexagon-$pointIndex-$hexIndex'),
          polygon: Polygon(
            outerRing: LinearRing(points: vertices),
            innerRings: [], // No inner rings for a simple hexagon
          ),
          fillColor: _getHexagonColor(pointIndex, hexIndex),
          strokeColor: Colors.white.withOpacity(0.8),
          strokeWidth: 1,
        );

        hexagons.add(hexagon);
      }
    }

    return hexagons;
  }

  // Helper function to generate different colors for visual variety
  Color _getHexagonColor(int pointIndex, int hexIndex) {
    if (hexIndex == 0) {
      // Center hexagon - slightly different color
      return Colors.red.withOpacity(0.8);
    }

    final colors = [
      Colors.red.withOpacity(0.6),
      Colors.deepOrange.withOpacity(0.6),
      Colors.orange.withOpacity(0.6),
      Colors.redAccent.withOpacity(0.6),
      Colors.red.shade300.withOpacity(0.6),
      Colors.red.shade400.withOpacity(0.6),
    ];

    // Use hex index for outer ring colors
    return colors[(hexIndex - 1) % colors.length];
  }
}
