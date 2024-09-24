import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/core/utils/price-fromatter.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/presentation/details/units/unit_item.dart';
import 'package:realtbox/presentation/details/units/unit_item_header.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'package:realtbox/presentation/widgets/border_text.dart';

class DetailsTab extends StatelessWidget {
  final Property property;

  const DetailsTab({super.key, required this.property});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: kSecondaryColor, spreadRadius: 1),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              property.units.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          BasicText(
                            text: property.projectName,
                            textStyle: const TextStyle(
                                fontSize: 25,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                          ),
                          property.projectBy.isNotEmpty
                              ? Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const BasicText(
                                          text: "By ",
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        BasicText(
                                          text: property.projectBy,
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: kPrimaryColor,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    )
                                  ],
                                )
                              : Container(),
                          const SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                            itemCount: property.units.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = property.units[index];
                              return UnitItem(unit: item);
                            },
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: size.width,
                          height: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: kPrimaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: kSecondaryColor, spreadRadius: 0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const BasicText(
                                  textAlign: TextAlign.center,
                                  text: 'Asset Value',
                                  textStyle: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                BasicText(
                                  textAlign: TextAlign.center,
                                  text:
                                      "\u{20B9} ${formatStringPrice(property.price)} / ${property.propertySize}",
                                  textStyle: const TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 8,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //category name
                    BorderedText(
                      text: property.categoryName,
                      borderColor: Colors.blueGrey,
                      borderRadius: 12.0,
                      borderWidth: 1,
                      textStyle: const TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s14,
                        fontFamily: FontConstants.fontFamily,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    //size
                    BorderedText(
                      text: property.subCategoryName,
                      borderColor: Colors.blueAccent,
                      borderRadius: 12.0,
                      borderWidth: 1,
                      textStyle: const TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s14,
                        fontFamily: FontConstants.fontFamily,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: lightgrey,
                  boxShadow: [
                    BoxShadow(color: kSecondaryColor, spreadRadius: 0.5),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BasicText(
                        text: "Description",
                        textStyle: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      BasicText(
                        text: property.description,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    /*  UnitItem(
      unit: property.units[0]
    )); */
  }
}
