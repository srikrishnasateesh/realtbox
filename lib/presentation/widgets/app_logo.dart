import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/assests_manager.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: Image.asset(authLogoImage,),
    );
  }
}
