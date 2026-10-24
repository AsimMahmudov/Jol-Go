class TripSearch {
  const TripSearch({
    required this.from,
    required this.to,
    required this.date,
    required this.passengers,
  });

  final String from;
  final String to;
  final DateTime date;
  final int passengers;

  // Из URL: /trips?from=Бишкек&to=Ош&date=2026-10-21&pax=2
  factory TripSearch.fromQuery(Map<String, String> query) {
    return TripSearch(
      from: query['from'] ?? 'Бишкек',
      to: query['to'] ?? 'Талас',
      date: DateTime.tryParse(query['date'] ?? '') ?? DateTime.now(),
      passengers: int.tryParse(query['pax'] ?? '') ?? 1,
    );
  }

  // В URL
  String toLocation() {
    return Uri(
      path: '/trips',
      queryParameters: {
        'from': from,
        'to': to,
        'date': date.toIso8601String().split('T').first,
        'pax': '$passengers',
      },
    ).toString();
  }
}
