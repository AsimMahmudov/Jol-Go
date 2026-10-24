import 'package:jol_go/data/models/booking.dart';
import 'package:jol_go/data/models/city.dart';
import 'package:jol_go/data/models/car.dart';
import 'package:jol_go/data/models/driver.dart';
import 'package:jol_go/data/models/trip.dart';
import 'package:jol_go/data/models/user.dart';
import 'package:jol_go/data/models/app_notification.dart';

const mockUser = User(
  id: 'u1',
  firstName: 'Асим',
  lastName: 'Махмудов',
  phone: '+996 708 771 849',
);

const mockCities = [
  City(id: 'bishkek', name: 'Бишкек', region: 'Чуйская область'),
  City(id: 'osh', name: 'Ош', region: 'Ошская область'),
  City(
    id: 'jalal-abad',
    name: 'Джалал-Абад',
    region: 'Джалал-Абадская область',
  ),
  City(id: 'karakol', name: 'Каракол', region: 'Иссык-Кульская область'),
  City(id: 'cholpon-ata', name: 'Чолпон-Ата', region: 'Иссык-Кульская область'),
  City(id: 'balykchy', name: 'Балыкчы', region: 'Иссык-Кульская область'),
  City(id: 'naryn', name: 'Нарын', region: 'Нарынская область'),
  City(id: 'talas', name: 'Талас', region: 'Таласская область'),
  City(id: 'batken', name: 'Баткен', region: 'Баткенская область'),
  City(id: 'tokmok', name: 'Токмок', region: 'Чуйская область'),
  City(id: 'kara-balta', name: 'Кара-Балта', region: 'Чуйская область'),
  City(id: 'kant', name: 'Кант', region: 'Чуйская область'),
  City(id: 'uzgen', name: 'Узген', region: 'Ошская область'),
  City(id: 'kara-suu', name: 'Кара-Суу', region: 'Ошская область'),
  City(id: 'kyzyl-kiya', name: 'Кызыл-Кия', region: 'Баткенская область'),
];

DateTime _todayAt(int hour, int minute) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, hour, minute);
}

DateTime _tomorrowAt(int hour, int minute) {
  return _todayAt(hour, minute).add(const Duration(days: 1));
}

final mockNotifications = [
  AppNotification(
    id: 'n1',
    message:
        'Азамат подтвердил место 1 на поездку Бишкек → Талас, '
        'сегодня в 07:30. Посадка: Западный автовокзал.',
    createdAt: DateTime.now().subtract(const Duration(minutes: 12)),
  ),
  AppNotification(
    id: 'n2',
    message:
        'Али подтвердил место 4 на поездку Бишкек → Талас, '
        'сегодня в 11:15. Посадка: Площадь Ала-Тоо.',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    isRead: true,
  ),
];

final mockBookings = [
  Booking(
    id: 'b1',
    trip: mockTrips[0],
    seatNumbers: [1],
    status: BookingStatus.pending,
  ),
  Booking(
    id: 'b2',
    trip: mockTrips[5],
    seatNumbers: [2, 3],
    status: BookingStatus.confirmed,
  ),
  Booking(
    id: 'b3',
    trip: mockTrips[2],
    seatNumbers: [4],
    status: BookingStatus.cancelled,
  ),
];

final mockTrips = [
  Trip(
    id: 't1',
    from: mockCities[0],
    to: mockCities[7],
    departureTime: _todayAt(7, 30),
    durationHours: 4,
    price: 1200,
    driver: const Driver(
      id: 'd1',
      name: 'Азамат Токтогулов',
      phone: '+996 708 771 849',
      rating: 4.9,
    ),
    car: const Car(
      model: 'Toyota Alphard',
      color: 'белый',
      plateNumber: '01KG 245ABE',
      seatCount: 6,
      isMinivan: true,
      photos: [
        'assets/images/0.jpeg',
        'assets/images/1.jpg',
        'assets/images/2.jpeg',
        'assets/images/3.webp',
      ],
    ),
    takenSeats: [2, 5],
    pickupPoint: 'Западный автовокзал',
    dropoffPoint: 'Центр города',
  ),
  Trip(
    id: 't2',
    from: mockCities[0],
    to: mockCities[7],
    departureTime: _todayAt(9, 0),
    durationHours: 4,
    price: 1100,
    driver: const Driver(
      id: 'd2',
      name: 'Бакыт Сыдыков',
      phone: '+996 553 428 002',
      rating: 4.8,
    ),
    car: const Car(
      model: 'Honda Odyssey',
      color: 'серый',
      plateNumber: '01KG 118AAC',
      seatCount: 4,
      isMinivan: true,
      photos: ['assets/images/adyssey-1.jpeg', 'assets/images/adyssey-2.jpg'],
    ),
    takenSeats: [1, 2, 3, 4],
    pickupPoint: 'Западный автовокзал',
    dropoffPoint: 'Центр города',
  ),
  Trip(
    id: 't3',
    from: mockCities[0],
    to: mockCities[7],
    departureTime: _todayAt(11, 15),
    durationHours: 4,
    price: 1300,
    driver: const Driver(
      id: 'd3',
      name: 'Али Махмудов',
      phone: '+996 708 771 849',
      rating: 5.0,
    ),
    car: const Car(
      model: 'Kia K5',
      color: 'чёрный',
      plateNumber: '07KG 007DNK',
      seatCount: 4,
      photos: ['assets/images/kia-1.jpg'],
    ),
    takenSeats: [1],
    pickupPoint: 'Площадь Ала-Тоо',
    dropoffPoint: 'Центр города',
  ),
  Trip(
    id: 't4',
    from: mockCities[0],
    to: mockCities[7],
    departureTime: _todayAt(14, 0),
    durationHours: 4,
    price: 1000,
    driver: const Driver(
      id: 'd4',
      name: 'Эрлан Мамытов',
      phone: '+996 553 428 002',
      rating: 4.7,
    ),
    car: const Car(
      model: 'Toyota Estima',
      color: 'белый',
      plateNumber: '01KG 501EM',
      seatCount: 4,
      isMinivan: true,
      photos: [
        'assets/images/Toyota-1.jpg',
        'assets/images/Toyota-2.jpg',
        'assets/images/Toyota-3.jpg',
      ],
    ),
    takenSeats: [1, 2, 3, 4, 5, 6],
    pickupPoint: 'Западный автовокзал',
    dropoffPoint: 'Центр города',
  ),
  Trip(
    id: 't5',
    from: mockCities[7],
    to: mockCities[0],
    departureTime: _todayAt(15, 0),
    durationHours: 4,
    price: 1200,
    driver: const Driver(
      id: 'd5',
      name: 'Улан Жээнбеков',
      phone: '+996 708 771 849',
      rating: 4.9,
    ),
    car: const Car(
      model: 'Hyundai Starex',
      color: 'белый',
      plateNumber: '01KG 330UJ',
      seatCount: 4,
      isMinivan: true,
      photos: ['assets/images/Hyundai-1.webp', 'assets/images/Hyundai-2.jpg'],
    ),
    takenSeats: [1, 3],
    pickupPoint: 'Автовокзал Талас',
    dropoffPoint: 'Западный автовокзал',
  ),
  Trip(
    id: 't6',
    from: mockCities[7],
    to: mockCities[0],
    departureTime: _tomorrowAt(8, 30),
    durationHours: 4,
    price: 1100,
    driver: const Driver(
      id: 'd6',
      name: 'Тимур Абдыкадыров',
      phone: '+996 553 428 002',
      rating: 4.6,
    ),
    car: const Car(
      model: 'Toyota Camry',
      color: 'серебристый',
      plateNumber: '01KG 812TA',
      seatCount: 4,
      photos: [
        'assets/images/Camry-1.jpeg',
        'assets/images/Camry-2.webp',
        'assets/images/Camry-3.webp',
        'assets/images/Camry-4.webp',
      ],
    ),
    takenSeats: [],
    pickupPoint: 'Центр города',
    dropoffPoint: 'Площадь Ала-Тоо',
  ),
];
