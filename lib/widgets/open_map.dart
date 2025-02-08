import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';

// ฟังก์ชันเปิดแผนที่ Google Maps หรือ Apple Maps
Future<void> openMap(double lat, double lng) async {
  final googleMapsUrl = Uri.parse("comgooglemaps://?center=$lat,$lng");
  final appleMapsUrl = Uri.parse("https://maps.apple.com/?q=$lat,$lng");
  final fallbackUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

  try {
    if (Platform.isAndroid) {
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl);
      } else {
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      }
    } else if (Platform.isIOS) {
      if (await canLaunchUrl(appleMapsUrl)) {
        await launchUrl(appleMapsUrl);
      } else {
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      }
    } else {
      await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    print('Could not launch map: $e');
  }
}