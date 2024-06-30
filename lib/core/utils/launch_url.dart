import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchCustomUrl(
  String url, {
  LaunchMode launchMode = LaunchMode.externalApplication,
}) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri,mode: launchMode)) {
    debugPrint('Could not launch $uri');
  }
}
