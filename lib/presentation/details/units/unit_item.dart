import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/data/model/property/property_response.dart';
import 'package:realtbox/presentation/details/units/unit_item_header.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';

class UnitItem extends StatelessWidget {
  final Unit unit;
  const UnitItem({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 300, // Specify a fixed width
      // margin: const EdgeInsets.only(right: 24.0),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UnitItemHeader(unitName: unit.unitName ?? ""),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: BasicText(
                      text: unit.getUnitSize(),
                      textStyle: const TextStyle(
                        color: grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 300,
                    child: BasicText(
                      text: unit.getUnitFacing(),
                      textStyle: const TextStyle(
                        color: grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 300,
                    child: BasicText(
                      text: unit.getUnitPrice(),
                      textStyle: const TextStyle(
                        color: kSecondaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
