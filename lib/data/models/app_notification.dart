class AppNotification {
  AppNotification({
    required this.id,
    required this.message,
    required this.createdAt,
    this.isRead = false,
  });

  final String id;
  final String message;
  final DateTime createdAt;

  bool isRead;
}
