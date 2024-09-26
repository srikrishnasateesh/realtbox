import 'package:flutter/material.dart';
import 'package:realtbox/core/utils/data_utils.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoTab extends StatefulWidget {
  final List<String> videoUrls;
  const VideoTab({super.key, required this.videoUrls});

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  List<String> videoIds = [];
  /* [
    "KGD-T3bhFEA",
    "WM6E6miPNCE",
    "dMUfqbapIRE",
  ]; */

  int currentIndex = 0;

  final YoutubePlayerController _controller = YoutubePlayerController(
    params: const YoutubePlayerParams(
      mute: true, // Start muted
      loop: false, // Disable loop
      showControls: true, // Show video controls
      showFullscreenButton: true, // Enable fullscreen button
    ),
  );

  @override
  void initState() {
    super.initState();
    // Load the initial video
    videoIds = widget.videoUrls.map((e) => extractYouTubeId(e) ?? "").toList();
    if (videoIds.isNotEmpty) {
      _controller.cueVideoById(videoId: videoIds[currentIndex]);
    }
  }

  void _nextVideo() {
    if (currentIndex < videoIds.length - 1) {
      setState(() {
        currentIndex++;
        _controller.cueVideoById(videoId: videoIds[currentIndex]);
      });
    }
  }

  void _previousVideo() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _controller.cueVideoById(videoId: videoIds[currentIndex]);
      });
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: videoIds.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    YoutubePlayer(
                      controller: _controller,
                      aspectRatio: 16 / 9,
                    ),
                    const SizedBox(height: 16),
                    videoIds.length > 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: _previousVideo,
                                tooltip: 'Previous Video',
                              ),
                              Text("${currentIndex + 1}/${videoIds.length}"),
                              IconButton(
                                icon: Icon(Icons.arrow_forward),
                                onPressed: _nextVideo,
                                tooltip: 'Next Video',
                              ),
                            ],
                          )
                        : Container(),
                  ],
                )
              : const BasicText(text: "Not available"),
        ),
      ),
    );
  }
}
