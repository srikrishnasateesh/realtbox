import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/presentation/carousel/carosel_widget.dart';

class PropertyDocumentsScreen extends StatelessWidget {
  final List<String> imageList;
  final bool isNetworkUrls;
  final bool autoScroll;
  final int activePage;
  const PropertyDocumentsScreen({
    super.key,
    required this.imageList,
    required this.isNetworkUrls,
    this.autoScroll = false,
    this.activePage = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselWidget(
          autoScroll: autoScroll,
          networkImages: isNetworkUrls,
          imagePaths: imageList,
          showZoomOut: true,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0, top: 24.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:  const CircleAvatar(
                child: Icon(
                  Icons.close_fullscreen_rounded,
                  size: 30,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
