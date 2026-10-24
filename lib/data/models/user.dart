class User {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.photoPath,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String? photoPath;

  String get name => '$firstName $lastName';

  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();

  User copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? photoPath,
    bool removePhoto = false,
  }) {
    return User(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      photoPath: removePhoto ? null : (photoPath ?? this.photoPath),
    );
  }
}
