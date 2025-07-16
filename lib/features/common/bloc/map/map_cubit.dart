// import 'package:bloc/bloc.dart';
// import 'package:flutter/foundation.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:lorry_driver_mini/core/location/map_service.dart';
// import 'package:lorry_driver_mini/features/common/bloc/map/map_state.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';
//
// class MapSelectCurrentLocationCubit extends Cubit<MapSelectCurrentLocationState> {
//   MapSelectCurrentLocationCubit() : super(MapInitial());
//
//   Future<void> getAddressName(Position latLng) async {
//     emit(MapLoading());
//
//     // Check for location permission
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       permission = await _getRequestPermission();
//     }
//
//     // If permission is still denied or denied forever, emit an error state
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       emit(MapError('Location permission is denied.'));
//       return;
//     }
//
//     // Fetch the address using the latitude and longitude
//     Placemark? placeMark = await MapService.getPlaceAddressByLatLng(Point(
//       latitude: latLng.latitude,
//       longitude: latLng.longitude,
//     ));
//     debugPrint("cubit: $placeMark");
//
//     if (placeMark != null) {
//       emit(MapSuccess("${placeMark.locality}, ${placeMark.street}",
//           Point(latitude: latLng.latitude, longitude: latLng.longitude)));
//     } else {
//       emit(MapError('Failed to get address name.'));
//     }
//   }
//
//   Future<void> launchMapsUrl(
//       Position userLocation, Position companyLocation) async {
//     final Uri url = Uri.parse(
//         'https://www.google.com/maps/dir/?api=1&origin=${userLocation.latitude},${userLocation.longitude}&destination=${companyLocation.latitude},${companyLocation.longitude}&travelmode=driving');
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     } else {
//       emit(MapError('Could not launch the map URL.'));
//     }
//   }
//
//   Future<void> getLocation() async {
//     emit(MapLoading());
//
//     // Request location permission
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       permission = await _getRequestPermission();
//     }
//
//     // Get the location if permission is granted
//     Position? position = await _getLocation(permission);
//
//     if (position != null) {
//       // emit(Map)
//       emit(MapLoading(
//           point: Point(
//               latitude: position.latitude, longitude: position.longitude)));
//     } else {
//       emit(MapError("Failed to get location"));
//     }
//   }
//
//   Future<LocationPermission> _getRequestPermission() async {
//     return await Geolocator.requestPermission();
//   }
//
//   Future<Position?> _getLocation(LocationPermission permission) async {
//     if (permission == LocationPermission.always ||
//         permission == LocationPermission.whileInUse) {
//       return await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.high);
//     }
//     return null;
//   }
//
//   Future<void> requestPermission() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       emit(MapError('Permission denied.'));
//     } else {
//       emit(MapLoading()); // Optional: add any specific state here if needed
//     }
//   }
// }
