import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'package:realtbox/presentation/widgets/border_text.dart';
import 'package:realtbox/presentation/widgets/buttons.dart';

class PropertyItem extends StatelessWidget {
  final Property property;
  final int index;
  final VoidCallback onEnquiryClicked;
  final VoidCallback onEnquiryListClicked;
  final bool showEnquiry;
  const PropertyItem({
    super.key,
    required this.property,
    required this.index,
    required this.onEnquiryClicked,
    required this.showEnquiry,
    required this.onEnquiryListClicked,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = property.images[0];
    return GestureDetector(
      onTap: () {
        final args = {"id": property.propertyId};
        Navigator.pushNamed(context, RouteNames.propertyDetails,
            arguments: args);
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
                    shadowColor: kPrimaryColor,
                    elevation: 4,
                    clipBehavior: Clip.antiAlias,
                    child: Ink.image(
                      image: NetworkImage(
                        imageUrl.objectUrl,
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
                      color: kPrimaryColor,
                      child: Text(
                        "${property.price} INR",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (showEnquiry)
                    Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: FilledButton.icon(
                              onPressed: () => onEnquiryClicked(),
                              icon: const Icon(Icons.announcement),
                              label: const Text('Enquire Now'),
                              iconAlignment: IconAlignment.start,
                              style: FilledButton.styleFrom(
                                  backgroundColor: Colors.grey)),
                        )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Hero(
                            tag: "title_${property.propertyId}",
                            child: BasicText(
                              text: property.projectName,
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSize.s20,
                                fontFamily: FontConstants.fontFamily,
                              ),
                            ),
                          ),
                        ),
                        !showEnquiry
                            ? InkWell(
                                onTap: onEnquiryListClicked,
                                child: const CircleAvatar(
                                    backgroundColor: kPrimaryColor,
                                    child: Icon(Icons.list_rounded)),
                              )
                            : Container(),
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
                            borderRadius: 2.0,
                            borderWidth: 1,
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize.s12,
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
                            borderRadius: 2.0,
                            borderWidth: 1,
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize.s12,
                              fontFamily: FontConstants.fontFamily,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          //size
                          BorderedText(
                            text: property.propertySize,
                            borderColor: Colors.pinkAccent,
                            borderRadius: 2.0,
                            borderWidth: 1,
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize.s12,
                              fontFamily: FontConstants.fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                            width: 4.0), // Optional space between icon and text
                        Expanded(
                          child: BasicText(
                            text: property.location,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                              fontSize: FontSize.s15,
                            ),
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
        child: Hero(
          tag: "price_${property.propertyId}",
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
