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
  RangeValues values = const RangeValues(0, 0);
  @override
  void initState() {
    if(widget.receivedValues!=null){

    values = widget.receivedValues!;
    } else {
      values = const RangeValues(0, 0);
    }
    setState(() {
      
    });
    super.initState();
  }
  @override
  void dispose() {
    values = const RangeValues(0, 0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CustomSliderTheme(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSliderSideLabel(),
            const SizedBox(height: 16),
          ],
        ),
      );

  Widget buildSliderSideLabel() {
    const double min = 0;
    const double max = 10000000;

    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSideLabel(min),
          Expanded(
            child: RangeSlider(
              values: values,
              min: min,
              max: max,
              divisions: 20,
              labels: RangeLabels(
                formatPrice(values.start),
                formatPrice(values.end),
              ),
              onChanged: (values) => {
                widget.onBudgetChange(values),
                setState(() => this.values = values)
              },
            ),
          ),
          buildSideLabel(max),
        ],
      ),
    );
  }

  Widget buildSideLabel(double value) => Container(
        width: 30,
        child: Text(
          formatPrice(value),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
}
