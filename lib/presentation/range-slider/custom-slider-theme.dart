import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';

class CustomSliderTheme extends StatelessWidget {
  final Widget child;

  const CustomSliderTheme({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double thumbRadius = 14;
    const double tickMarkRadius = 8;

    const activeColor = kPrimaryColor;
    final inactiveColor = kPrimaryColor.withAlpha(70);

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 5,

        /// Thumb
        rangeThumbShape: const RoundRangeSliderThumbShape(
          disabledThumbRadius: thumbRadius,
          enabledThumbRadius: thumbRadius,
        ),

        /// Tick Mark
        rangeTickMarkShape:
            const RoundRangeSliderTickMarkShape(tickMarkRadius: tickMarkRadius),

        /// Inactive
        inactiveTickMarkColor: inactiveColor,
        inactiveTrackColor: inactiveColor,

        /// Active
        thumbColor: activeColor,
        activeTrackColor: activeColor,
        activeTickMarkColor: activeColor,
      ),
      child: child,
    );
  }
}