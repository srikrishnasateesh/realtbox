
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/utils/dialog_utils.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';
import 'package:realtbox/presentation/enquiry/bloc/enquiry_bloc.dart';
import 'package:realtbox/presentation/property_details/bloc/propert_detail_bloc.dart';
import 'package:realtbox/presentation/property_details/property_detail_appbar.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'package:realtbox/presentation/widgets/buttons.dart';
import 'package:realtbox/presentation/enquiry/enquiry_form_bottomsheet.dart';
import 'package:realtbox/presentation/widgets/key_value_column.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final Property property;
  bool showEnquiry = false;
  PropertyDetailsScreen({super.key, required this.property});
  @override
  Widget build(BuildContext context) {
    String enroll = LocalStorage.getString(StringConstants.enrollmentType);
    debugPrint("Enrool: $enroll");
    showEnquiry = enroll != StringConstants.enrollmentTypeAdmin;

    return BlocListener<PropertDetailBloc, PropertDetailState>(
      listener: (context, state) {
        if (state is OnEnquirySubmittedSuccessfully) {
          showConfirmationDialog(
            context,
            title: "Confirmation",
            content: "Your response received successfully",
            confirmButtonText: "Ok",
            onConfirmed: () {},
            onCancelled: () {},
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              PropertyDetailAppBar(
                imageUrls: property.images.map((e)=>e.objectUrl).toList(),
                onFullScreenPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.propertyDocs,
                    arguments: {
                      "images": property.images,
                      "network_images": true,
                    },
                  ).then(
                    (onValue) => {
                      debugPrint("Details:before calling bloc"),
                      debugPrint("Details:after calling bloc"),
                    },
                  );
                },
                onEnquiryListPressed: () {},
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: "title_${property.propertyId}",
                        child: BasicText(
                          text: property.projectName,
                          textStyle: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),

                      SizedBox(height: showEnquiry ? 16.0 : 0),
                      if (showEnquiry)
                        Center(
                          child: primaryButton("Enquire Now", action: () {
                            showBottomSheet(context, property.propertyId);
                          }),
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
                      KeyValueColumn(
                        displayKey: "Property type",
                        displayValue: property.categoryName,
                      ),
                      KeyValueColumn(
                        displayKey: "Property Size",
                        displayValue: property.propertySize,
                      ),
                      KeyValueColumn(
                        displayKey: "Location",
                        displayValue: property.location,
                      ),
                      KeyValueColumn(
                        displayKey: "Description",
                        displayValue: property.description,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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

  void showBottomSheet(
    BuildContext context,
    String propertyId,
  ) async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => EnquiryBloc(getIt<SubmitEnquiry>()),
        child: BottomSheetWidget(
          propertyId: propertyId,
        ),
      ),
    );
  }
}
