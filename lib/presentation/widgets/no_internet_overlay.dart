import 'package:flutter/material.dart';

class NoInternetOverlay extends ModalRoute<void> {
  @override
  Color? get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => 'No Internet Connection';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: const Text(
          'No internet connection. Please check your connection.',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
