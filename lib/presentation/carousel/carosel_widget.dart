import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/presentation/carousel/bloc/carousel_bloc.dart';

abstract class NavigationCallback {
  void navigateToNext();
}

class CarouselWidget extends StatefulWidget {
  final bool autoScroll;
  final bool networkImages;
  final List<String> imagePaths;
  final int activePage;
  final bool showZoomOut;
  CarouselWidget({
    super.key,
    required this.autoScroll,
    required this.networkImages,
    required this.imagePaths,
    this.activePage = 0,
    this.showZoomOut = false,
  });

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

late List<String> imagePaths;
late List<Widget> pagerViews;
int _activePage = 0;
Timer? timer;

class _CarouselWidgetState extends State<CarouselWidget>
    implements NavigationCallback {
  final carouselController = PageController();

  void startTimer() {
    debugPrint("startTimer:");
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      debugPrint("startTimer: $timer");
      if (carouselController.page == imagePaths.length - 1) {
        debugPrint("startTimer:going to first");
        carouselController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        debugPrint("startTimer:going to last");
        carouselController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _activePage = widget.activePage;
    imagePaths = widget.imagePaths;
    pagerViews = List.generate(imagePaths.length, (index) {
      if (!widget.networkImages) {
        return ImageProvider(
          path: imagePaths[index],
        );
      } else {
        return NetworkImageProvider(
          path: imagePaths[index],
        );
      }
    });
    debugPrint(
        "initState- autoScroll: ${widget.autoScroll}, timer: $timer, isActive: ${timer?.isActive} ");
    if (widget.autoScroll) {
      startTimer();
    } else {
      cancelTimer();
    }
  }

  @override
  void dispose() {
    debugPrint("Dispose-Carousel");
    carouselController.dispose();
    // cancelTimer();
    super.dispose();
  }

  void cancelTimer() {
    debugPrint("Cancelling timer");
    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade300,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                //height: MediaQuery.of(context).size.height / 3,
                child: PageView.builder(
                  controller: carouselController,
                  onPageChanged: (value) => {
                    if (mounted)
                      {
                        setState(() {
                          _activePage = value;
                        })
                      }
                  },
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index) {
                    return pagerViews[index];
                  },
                ),
              ),
              Positioned(
                left: 0,
                bottom: 10,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        pagerViews.length,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: InkWell(
                                onTap: () {
                                  carouselController.animateToPage(index,
                                      duration:
                                          const Duration(microseconds: 300),
                                      curve: Curves.easeIn);
                                },
                                child: CircleAvatar(
                                  radius: 4,
                                  backgroundColor: _activePage == index
                                      ? Colors.amberAccent
                                      : Colors.grey,
                                ),
                              ),
                            )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void navigateToNext() {
    cancelTimer();
  }
}

class ImageProvider extends StatelessWidget {
  final String path;
  const ImageProvider({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        path,
        fit: BoxFit.contain,
      ),
    );
  }
}

class NetworkImageProvider extends StatelessWidget {
  final String path;
  const NetworkImageProvider({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(
          path,
          fit: BoxFit.cover,
        ));
  }
}
