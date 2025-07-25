// Mock data models
class LocationItemModel {
  final String title;
  final String subtitle;
  final double latitude;
  final double longitude;
  final bool isSaved;
  final bool isRecent;

  LocationItemModel({
    required this.title,
    required this.subtitle,
    required this.latitude,
    required this.longitude,
    this.isSaved = false,
    this.isRecent = false,
  });
}