import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'package:realtbox/presentation/widgets/primary_button.dart';

class PropertyItemNew extends StatelessWidget {
  final Property property;
  final int index;
  final VoidCallback onEnquiryClicked;
  final VoidCallback onEnquiryListClicked;
  final bool showEnquiry;
  const PropertyItemNew({
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
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Ink.image(
                  image: NetworkImage(
                    imageUrl,
                  ),
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //name,loc,price
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BasicText(
                            text: property.projectName,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          BasicText(
                            text: '\u{20B9} ${property.price}',
                            textStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(locationPinSvg),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: Text(
                                  property.location,
                                  style: const TextStyle(
                                    color: blueGreyColor,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //actions
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              showEnquiry
                                  ? onEnquiryClicked()
                                  : onEnquiryListClicked();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Text(
                              showEnquiry ? "Enquiry Now" : "Enquiry List",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                          width: 150,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteNames.propertyDetails,
                                  arguments: property);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: kSecondaryColor)
                              ),
                            
                            ),
                            child: const Text(
                              "View Project",
                              style: TextStyle(
                                fontSize: 10,
                                color: kSecondaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
