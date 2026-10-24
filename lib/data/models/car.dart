class Car {
  const Car({
    required this.model,
    required this.color,
    required this.plateNumber,
    required this.seatCount,
    this.isMinivan = false,
    this.photos = const [],
  });

  final String model;
  final String color;
  final String plateNumber;
  final int seatCount;
  final bool isMinivan;
  final List<String> photos;
}
