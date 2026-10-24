import 'package:url_launcher/url_launcher.dart';

class ContactLauncher {
  ContactLauncher._();

  static String _digits(String phone) =>
      phone.replaceAll(RegExp(r'[^0-9]'), '');

  static Future<bool> call(String phone) {
    return _open(Uri(scheme: 'tel', path: '+${_digits(phone)}'));
  }

  static Future<bool> whatsApp(String phone, {String? message}) {
    return _open(
      Uri.https(
        'wa.me',
        '/${_digits(phone)}',
        message == null ? null : {'text': message},
      ),
    );
  }

  static Future<bool> _open(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}
