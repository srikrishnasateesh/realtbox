import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

part 'internet_state.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isOnline = true;
  bool get isOnline => _isOnline;
  final Connectivity connectivity = Connectivity();
  ConnectivityProvider() {
    connectivity.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        debugPrint("ConnectivityProvider:Connection connected");
        _isOnline = true;
      } else {
        debugPrint("ConnectivityProvider:Connection lost");
        _isOnline = false;
      }
    });
  }
}

class InternetCubit extends Cubit<bool> {
  final Connectivity connectivity = Connectivity();
  StreamSubscription? connectivityStreamSubscription;

  bool _isOnline = true;
  bool get isOnline => _isOnline;

  InternetCubit() : super(true) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        debugPrint("InternetCubit:Connection connected");
        _isOnline = true;
        emit(true);
      } else {
        debugPrint("InternetCubit:Connection lost");
        _isOnline = false;
        emit(false);
      }
    });
  }
}
