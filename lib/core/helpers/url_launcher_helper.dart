import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_logger.dart';

@lazySingleton
class UrlLauncherHelper {
  Future<void> callPhone(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      await launchUrl(launchUri);
    } catch (e) {
      CustomLogger.bgRed("Could not launch phone: $e");
    }
  }

  Future<void> launchWhatsApp(String phoneNumber) async {
    final String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final String whatsappUrl = "https://wa.me/$cleanNumber";
    final Uri launchUri = Uri.parse(whatsappUrl);

    try {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      CustomLogger.bgRed("Could not launch WhatsApp: $e");
    }
  }
}
