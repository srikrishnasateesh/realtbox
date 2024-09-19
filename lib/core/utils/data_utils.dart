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