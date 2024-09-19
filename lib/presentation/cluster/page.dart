import 'package:flutter/material.dart';

abstract class GoogleMapPage extends StatelessWidget {
  const GoogleMapPage(this.leading, this.title, {super.key});

  final Widget leading;
  final String title;
}