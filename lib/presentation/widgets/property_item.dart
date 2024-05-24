import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'package:realtbox/presentation/widgets/key_value_column.dart';
import 'package:realtbox/presentation/widgets/key_value_row.dart';

class PropertyItem extends StatelessWidget {
  final Property property;
  const PropertyItem({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = property.images[0];
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Card(
                shadowColor: Colors.red,
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Ink.image(
                  image: NetworkImage(
                    imageUrl,
                  ),
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            color: Colors.blueGrey,
            child:  Text(
              property.categoryName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Text(
                  property.projectName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: KeyValueColumn(
                        keyText: "Property Size",
                        valueText: property.propertySize,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: KeyValueColumn(
                        keyText: "Asset Value",
                        valueText: property.price,
                        keyColor: Colors.cyan,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: KeyValueColumn(
                        keyText: "Location",
                        valueText: property.location,
                        keyColor: Colors.cyan,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}