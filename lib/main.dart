import 'package:flutter/material.dart';
import 'package:realtbox/di.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  runApp(const MyApp());
}

