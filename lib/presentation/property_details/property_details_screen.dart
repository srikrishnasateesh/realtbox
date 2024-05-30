import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/presentation/property_details/property_detail_appbar.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final Property property;
  const PropertyDetailsScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          PropertyDetailAppBar(
            imageUrls: property.images,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasicText(
                    text: property.projectName,
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Asset Value',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 32.0,
                            width: 32.0,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 8.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor,
                            ),
                            child: const Icon(
                              Icons.currency_rupee_rounded,
                              color: Colors.white,
                            ),
                          ),
                          BasicText(
                            text: property.price,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.s20,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //property type
                  customKeyValue(
                    context,
                    "Property type",
                    property.categoryName,
                  ),
                  customKeyValue(
                    context,
                    "Property Size",
                    property.propertySize,
                  ),
                  customKeyValue(
                    context,
                    "Location",
                    property.location,
                  ),
                  customKeyValue(
                    context,
                    "Description",
                    property.description,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customKeyValue(BuildContext context, String key, String value) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          const Divider(color: kOutlineColor, height: 1.0),
          const SizedBox(height: 16.0),
          BasicText(
            text: key,
            textStyle: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8.0),
          BasicText(
            text: value,
            textStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: kSecondaryTextColor),
          ),
        ]);
  }
}
