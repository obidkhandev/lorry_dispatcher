// Mock data models
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationItemModel {
  final String title;
  final String subtitle;
  final double latitude;
  final double longitude;
  final bool isSaved;
  final bool isRecent;
  final SuggestItemType type;

  LocationItemModel({
    required this.title,
    required this.subtitle,
    required this.latitude,
    required this.longitude,
     this.type = SuggestItemType.unknown,
    this.isSaved = false,
    this.isRecent = false,
  });
}