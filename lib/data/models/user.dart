class User {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String phone;

  String get name => '$firstName $lastName';

  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();
}
