import 'package:jol_go/data/models/trip.dart';

enum BookingStatus {
  pending('Ожидании'),
  confirmed('Подтверждена'),
  cancelled('Отменена');

  const BookingStatus(this.label);

  final String label;
}

class Booking {
  const Booking({
    required this.id,
    required this.trip,
    required this.seatNumbers,
    required this.status,
  });

  final String id;
  final Trip trip;
  final List<int> seatNumbers;
  final BookingStatus status;

  int get totalPrice => trip.price * seatNumbers.length;

  bool get isUpcoming {
    if (status == BookingStatus.cancelled) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return !trip.departureTime.isBefore(today);
  }

  Booking copyWith({BookingStatus? status}) {
    return Booking(
      id: id,
      trip: trip,
      seatNumbers: seatNumbers,
      status: status ?? this.status,
    );
  }
}
