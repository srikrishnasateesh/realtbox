import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/entity/amenity.dart';
import 'package:realtbox/domain/usecase/amenity-list.dart';
import 'package:realtbox/presentation/amenities/amenities-select-list.dart';
import 'package:realtbox/presentation/amenities/bloc/amenities_bloc.dart';
import 'package:realtbox/presentation/budget-dropdown/bloc/budget_dropdown_bloc.dart';
import 'package:realtbox/presentation/budget-dropdown/budget-dropdown-field.dart';
import 'package:realtbox/presentation/property-filter/property-filter-entity.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'dart:async';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = "AIzaSyCrfbDrpH9weSNGdtwKKfIP0RSjz6hSTRs";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class PropertyFiltersScreen extends StatelessWidget {
  final PropertyFilter propertyFilter;
  PropertyFiltersScreen({super.key, required this.propertyFilter});

  @override
  Widget build(BuildContext context) {
    debugPrint("Received Back : ${propertyFilter.selectedAmenities.join(",")}");
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _buildFooter(context),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 30,
                  )),
            )
          ],
        ),
        body: Stack(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(12.0, 8, 0, 8),
                          child: BasicText(
                            text: "Filters",
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FontSize.s25),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BasicText(
                                text: "Amenities",
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10,),
                              BlocProvider(
                                create: (context) =>
                                    AmenitiesBloc(getIt<GetAmenityList>()),
                                child: AmenitiesSelection(
                                  selectedAmenities: propertyFilter.selectedAmenities,
                                  onAmenitiesSelected: (amenities) {
                                    propertyFilter.selectedAmenities = amenities;
                                    debugPrint(
                                        "amenities:selected ${amenities.join()}");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        /*  BlocProvider(
                        create: (context) => BudgetDropdownBloc(),
                        child: BudgetDropDownFiled(
                          title: "Budget",
                          onValueChanged: (String? selectedValue) {
                            debugPrint("Budget: $selectedValue");
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await _handlePressButton(context);
                        },
                        child: const Text("Search Location"),
                      ) */
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 241, 244, 247),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                 debugPrint("clear all");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: kSecondaryColor,
              ),
              child: const Text('CLEAR ALL'),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: ElevatedButton.icon(
              icon: Icon(Icons.search),
              onPressed: () {
                debugPrint("Search");
                Navigator.pop(context,propertyFilter);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              label: const Text('SEARCH'),
            ),
          ),
        ],
      ),
    );
  }
}

void onError(PlacesAutocompleteResponse response) {
  debugPrint("Places error : ${response.errorMessage}");
}

Future<void> _handlePressButton(BuildContext context) async {
  // show input autocomplete with selected mode
  // then get the Prediction selected
  Prediction? p = await PlacesAutocomplete.show(
    context: context,
    apiKey: kGoogleApiKey,
    onError: onError,
    mode: Mode.overlay,
    language: "en",
    decoration: InputDecoration(
      hintText: 'Search by location',
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.white,
        ),
      ),
    ),
    components: [Component(Component.country, "IN")],
  );
  debugPrint("Prediction result: $p");
  if (p != null) {
    displayPrediction(p);
  }
}

Future<Null> displayPrediction(Prediction p) async {
  if (p.placeId != null) {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);

    var placeId = p.placeId;
    double lat = detail.result.geometry?.location.lat ?? 0.0;
    double lng = detail.result.geometry?.location.lng ?? 0.0;

    // var address = await Geocoder.local.findAddressesFromQuery(p.description);

    print(lat);
    print(lng);
  }
}
