import 'package:jol_go/data/models/car.dart';
import 'package:jol_go/data/models/city.dart';
import 'package:jol_go/data/models/driver.dart';

class Trip {
  const Trip({
    required this.id,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.durationHours,
    required this.price,
    required this.driver,
    required this.car,
    required this.takenSeats,
    required this.pickupPoint,
    required this.dropoffPoint,
  });

  final String id;
  final City from;
  final City to;
  final DateTime departureTime;
  final int durationHours;
  final int price;
  final Driver driver;
  final Car car;
  final List<int> takenSeats;
  final String pickupPoint;
  final String dropoffPoint;

  int get freeSeats => car.seatCount - takenSeats.length;
  DateTime get arrivalTime => departureTime.add(Duration(hours: durationHours));
  bool get isFull => freeSeats == 0;
}
