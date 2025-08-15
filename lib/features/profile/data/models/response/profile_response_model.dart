class ProfileResponseModel {
  final String firstName;
  final String lastName;

  ProfileResponseModel({
    required this.firstName,
    required this.lastName,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }
}
