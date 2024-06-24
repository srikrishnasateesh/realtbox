import 'package:flutter/material.dart';

List<Widget> modelBuilder<M>(
        List<M> models, Widget Function(int index, M model) builder) =>
    models
        .asMap()
        .map<int, Widget>(
            (index, model) => MapEntry(index, builder(index, model)))
        .values
        .toList();
