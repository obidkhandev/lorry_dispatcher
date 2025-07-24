import 'package:google_maps_flutter/google_maps_flutter.dart';

class CountryRegionModel{
  final String name;
  final LatLng latLng;

  CountryRegionModel({required this.name, required this.latLng});
}