import 'package:url_launcher/url_launcher.dart';

String? extractYouTubeId(String url) {
  final RegExp youtubeRegex = RegExp(
    r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
  );
  
  final Match? match = youtubeRegex.firstMatch(url);
  if (match != null && match.groupCount >= 1) {
    return match.group(1); // Extracts the first capturing group, which is the video ID.
  }
  return null; // Returns null if no ID is found.
}

String getFileExtension(String url) {
  Uri uri = Uri.parse(url);
  String path = uri.path;
  
  // Get the last segment of the path
  String lastSegment = path.split('/').last;
  
  // Return the extension by splitting at the last dot
  String extension = lastSegment.split('.').last;
  
  return extension;
}

openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
     if (await canLaunchUrl(Uri.parse(googleUrl))) {
        await launchUrl(Uri.parse(googleUrl));
     } else {
        throw 'Could not open the map.';
     }
  }