// import 'package:geocoding/geocoding.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';
//
// class MapService {
//   static Future<Placemark?> getPlaceAddressByLatLng(Point latLng) async {
//     GeocodingPlatform.instance?.setLocaleIdentifier("uz");
//     final List<Placemark> placeMarks = await placemarkFromCoordinates(
//       latLng.latitude,
//       latLng.longitude,
//     );
//
//     if (placeMarks.isNotEmpty) return placeMarks[0];
//     return null;
//   }
// }