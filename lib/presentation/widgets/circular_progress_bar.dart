import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  CircularProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: Stack(
        children: [
          ModalBarrier(
              dismissible: false, color: Colors.transparent),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    semanticsLabel: 'Circular progress indicator',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
