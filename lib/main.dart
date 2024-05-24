import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/firebase_options.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDI();
  runApp(const MyApp());
}