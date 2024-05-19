import 'package:flutter/material.dart';

class ProgressLoader extends StatefulWidget {
  const ProgressLoader({super.key});

  @override
  State<ProgressLoader> createState() =>
      _ProgressLoaderState();
}

class _ProgressLoaderState extends State<ProgressLoader>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(  vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                value: controller.value,
                semanticsLabel: 'Circular progress indicator',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
