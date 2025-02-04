import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';

class AuthStackImage extends StatelessWidget {
  const AuthStackImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              color: kPrimaryColor,
              height: 200,
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: Image.asset(
                      authHeaderBannerImage,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
     ],
    );
  }
}
