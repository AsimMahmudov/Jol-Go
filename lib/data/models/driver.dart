class Driver {
  const Driver({
    required this.id,
    required this.name,
    required this.phone,
    required this.rating,
  });

  final String id;
  final String name;
  final String phone;
  final double rating;

  String get firstName => name.split(' ').first;

  String get initials =>
      name.split(' ').map((part) => part[0]).take(2).join().toUpperCase();
}
