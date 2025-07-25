import 'package:lorry_dispatcher/features/create_order/data/models/location_item_model.dart';

final List<LocationItemModel> recentLocations = [
  LocationItemModel(
    title: "Mega Planet",
    subtitle: "Toshkent, Yashnobod tumani, Mega Planet savdo markazi",
    latitude: 41.2856,
    longitude: 69.2034,
    isRecent: true,
  ),
  LocationItemModel(
    title: "Oloy bozori",
    subtitle: "Toshkent, Chilonzor tumani, Oloy bozori",
    latitude: 41.2618,
    longitude: 69.2037,
    isRecent: true,
  ),
  LocationItemModel(
    title: "Toshkent City",
    subtitle: "Toshkent, Shayxontohur tumani, Toshkent City",
    latitude: 41.3088,
    longitude: 69.2798,
    isRecent: true,
  ),
  LocationItemModel(
    title: "Minor metro",
    subtitle: "Toshkent, Yunusobod tumani, Minor metrosi",
    latitude: 41.3614,
    longitude: 69.2891,
    isRecent: true
  ),
];

// Mock search results
final List<LocationItemModel> searchResultsData = [
  LocationItemModel(
    title: "Chorsu bozori",
    subtitle: "Toshkent, Uchtepa tumani, Chorsu bozori",
    latitude: 41.3294,
    longitude: 69.2348,
  ),
  LocationItemModel(
    title: "Buyuk Ipak Yo'li",
    subtitle: "Toshkent, Mirzo Ulug'bek tumani, Buyuk Ipak Yo'li",
    latitude: 41.3447,
    longitude: 69.3372,
  ),
  LocationItemModel(
    title: "Minor masjidi",
    subtitle: "Toshkent, Yunusobod tumani, Minor masjidi",
    latitude: 41.3614,
    longitude: 69.2891,
  ),
];