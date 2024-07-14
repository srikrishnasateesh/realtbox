import 'package:realtbox/core/listeners/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/no_internet_overlay.dart';

class ConnectivityStatus extends StatelessWidget {
  final Widget child;

  const ConnectivityStatus({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: BlocListener<InternetCubit, bool>(
            listener: (context, isConnected) {
              if (!isConnected) {
               // Navigator.of(context).push(NoInternetOverlay());
              } else {
                //Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            child: child,
          ),
        ),
      ),
    );
  }
}
