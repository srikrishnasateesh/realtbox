import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realtbox/config/resources/color_manager.dart';

class PropertyDetailAppBar extends StatefulWidget {
  final List<String> imageUrls;
  final VoidCallback onFullScreenPressed;
  final VoidCallback onEnquiryListPressed;

  const PropertyDetailAppBar({
    super.key,
    required this.imageUrls,
    required this.onFullScreenPressed,
    required this.onEnquiryListPressed,
  });

  @override
  State<PropertyDetailAppBar> createState() => _PropertyDetailAppBarState();
}

int _activePage = 0;
Timer? timer;

class _PropertyDetailAppBarState extends State<PropertyDetailAppBar> {
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    pageController.dispose();
    super.dispose();
  }

  void startTimer() {
    debugPrint("startTimer:");
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      debugPrint("startTimer: $timer");
      if ((pageController.page ?? 0) < widget.imageUrls.length - 1) {
        pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      expandedHeight: 275.0,
      backgroundColor: Colors.white,
      elevation: 0.0,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            //build pager to show images
            PageView.builder(
                controller: pageController,
                itemCount: widget.imageUrls.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.imageUrls[index],
                    fit: BoxFit.cover,
                  );
                }),

            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 24.0, top: 12.0),
                child: IconButton(
                  onPressed: () {
                    widget.onFullScreenPressed();
                  },
                  icon: const CircleAvatar(
                    child: Icon(
                      Icons.fullscreen_rounded,
                      size: 30,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 16.0,
              child: Container(
                height: 48,
                width: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.40),
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: Container(
          height: 32.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
            ),
          ),
          child: Container(
            width: 40.0,
            height: 5.0,
            decoration: BoxDecoration(
              color: kOutlineColor,
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
        ),
      ),
    );
  }
}
