import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';

class PropertyItem extends StatelessWidget {
  final Property property;
  final int index;
  const PropertyItem({Key? key, required this.property, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = property.images[0];
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.propertyDetails,
            arguments: property);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Card(
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
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      color: Colors.green,
                      child: Text(
                        "${property.price} INR",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: const BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    10)), // Set the border radius here
                          ),
                          child: Text(
                            property.categoryName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasicText(
                      text: property.projectName,
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s28,
                        fontFamily: FontConstants.fontFamily,
                      ),
                    ),
                    //propertyValueAndSize(),
                    const SizedBox(
                      height: FontSize.s12,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.amberAccent,
                        ),
                        const SizedBox(
                            width: 4.0), // Optional space between icon and text
                        BasicText(
                          text: property.location,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontSize: FontSize.s15,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row propertyValueAndSize() {
    return Row(children: [
      Expanded(
        flex: 1,
        child: RichText(
          text: TextSpan(
            text: property.price,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: FontSize.s25,
              fontFamily: FontConstants.fontFamily,
            ),
            children: const <InlineSpan>[
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 5.0),
                ),
              ),
              TextSpan(
                text: 'INR',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: FontSize.s18,
                  fontFamily: FontConstants.fontFamily,
                ),
              ),
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: RichText(
          text: TextSpan(
            text: property.propertySize,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: FontSize.s20,
              fontFamily: FontConstants.fontFamily,
            ),
            children: const <InlineSpan>[
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 5.0),
                ),
              ),
              TextSpan(
                text: 'size',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: FontSize.s12,
                  fontStyle: FontStyle.italic,
                  fontFamily: FontConstants.fontFamily,
                ),
              ),
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
