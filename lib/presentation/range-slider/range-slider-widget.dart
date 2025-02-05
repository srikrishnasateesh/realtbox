import 'package:flutter/material.dart';
import 'package:realtbox/core/utils/model-builder-util.dart';
import 'package:realtbox/core/utils/price-fromatter.dart';
import 'package:realtbox/presentation/range-slider/custom-slider-theme.dart';

class RangeSliderWidget extends StatefulWidget {
  final RangeValues? receivedValues;
  final Function(RangeValues) onBudgetChange;
  
  RangeSliderWidget({
    super.key,
    required this.onBudgetChange,
    required this.receivedValues,
  });

  @override
  _RangeSliderWidgetState createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  static const double minRange = 1;  // Updated min value
  static const double maxRange = 10000000; // Max value remains same
  RangeValues values = const RangeValues(minRange, maxRange);

  @override
  void initState() {
    super.initState();
    reset();
  }

  @override
  void dispose() {
    values = const RangeValues(minRange, maxRange);
    super.dispose();
  }

  reset() {
    if (widget.receivedValues != null) {
      values = RangeValues(
        widget.receivedValues!.start.clamp(minRange, maxRange),
        widget.receivedValues!.end.clamp(minRange, maxRange),
      );
    } else {
      values = const RangeValues(minRange, maxRange);
    }
  }

  @override
  Widget build(BuildContext context) {
    reset();
    return CustomSliderTheme(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSliderSideLabel(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildSliderSideLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSideLabel(minRange),
        Expanded(
          child: RangeSlider(
            values: values,
            min: minRange,
            max: maxRange,
            divisions: 20,
            labels: RangeLabels(
              formatPrice(values.start),
              formatPrice(values.end),
            ),
            onChanged: (values) => {
              widget.onBudgetChange(values),
              setState(() => this.values = values),
            },
          ),
        ),
        buildSideLabel(maxRange),
      ],
    );
  }

  Widget buildSideLabel(double value) => SizedBox(
        width: 50,
        child: Text(
          formatPrice(value),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
}
