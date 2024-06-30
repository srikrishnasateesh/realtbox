class VersionResponse {
  final bool forceUpgrade;
  final bool recommendUpgrade;

  VersionResponse({
    required this.forceUpgrade,
    required this.recommendUpgrade,
  });
}
