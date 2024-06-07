import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';


Widget primaryButton(String btnName, {required Function action}
) {
    return FittedBox(
      child: RawMaterialButton(
        fillColor: ColorManager.green,
        splashColor: Colors.black12,
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Center(
            child: Text(
              btnName,
              style: const TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ),
        ),
        onPressed: () {
          action();
        },
      ),
    );
  }