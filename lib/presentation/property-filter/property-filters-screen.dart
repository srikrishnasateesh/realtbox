import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/usecase/amenity-list.dart';
import 'package:realtbox/presentation/amenities/amenities-select-list.dart';
import 'package:realtbox/presentation/amenities/bloc/amenities_bloc.dart';
import 'package:realtbox/presentation/property-filter/bloc/property_filetr_bloc.dart';
import 'package:realtbox/presentation/property-filter/property-filter-entity.dart';
import 'package:realtbox/presentation/range-slider/bloc/range_slider_bloc.dart';
import 'package:realtbox/presentation/range-slider/range-slider-widget.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'dart:async';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = "AIzaSyApTWGv8sRNySOYo_JISDZIZGbmmXC2H9o";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class PropertyFiltersScreen extends StatelessWidget {
  final PropertyFilter propertyFilter;
  PropertyFiltersScreen({super.key, required this.propertyFilter});

  @override
  Widget build(BuildContext context) {
    // debugPrint("Received Back : ${propertyFilter.selectedAmenities.join(",")}");
    TextEditingController locationController = TextEditingController(text: "");
    context
        .read<PropertyFilterBloc>()
        .add(OnFilterInit(propertyFilter: propertyFilter));
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
                    Navigator.pop(context, propertyFilter);
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
            BlocBuilder<PropertyFilterBloc, PropertyFilterState>(
              builder: (context, state) {
                if (state is LoadFilters) {
                  debugPrint(
                      "Budget:${state.propertyFilter.selectedBudget.rangeValues}");
                  locationController.text =
                      state.propertyFilter.selectedLocation?.address ?? "";
                  return ListView(
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
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Budget
                                  const BasicText(
                                    text: "Budget",
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
            
                                  BlocProvider(
                                    create: (context) => RangeSliderBloc(),
                                    child: RangeSliderWidget(
                                      receivedValues: state.propertyFilter
                                          .selectedBudget.rangeValues,
                                      onBudgetChange: (p0) {
                                        context
                                            .read<PropertyFilterBloc>()
                                            .add(OnBudgetChanged(
                                                rangeValues: p0));
                                      },
                                    ),
                                  ),
            
                                  const SizedBox(
                                    height: 20,
                                  ),
            
                                  //location
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const BasicText(
                                        text: "Location",
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      if (locationController.text.isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<PropertyFilterBloc>()
                                                .add(OnPlaceDetailCleared());
                                          },
                                          child: const BasicText(
                                            text: "Clear",
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
            
                                  InkWell(
                                    onTap: () async {
                                      PlaceDetail? placeDetail =
                                          await _handleLocationSearch(
                                              context);
                                      debugPrint(
                                          "location3: ${placeDetail.toString()}");
                                      BlocProvider.of<PropertyFilterBloc>(
                                              context)
                                          .add(OnPlaceDetailSelected(
                                              placeDetail: placeDetail));
                                    },
                                    child: TextField(
                                      controller: locationController,
                                      keyboardType: TextInputType.text,
                                      enabled: false,
                                      minLines: 1,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          color: kSecondaryColor),
                                      decoration: InputDecoration(
                                        counterText: "",
                                        prefixIcon: Align(
                                          widthFactor: 1.0,
                                          heightFactor: 1.0,
                                          child: SvgPicture.asset(
                                            locationPinSvg,
                                          ),
                                        ),
                                        labelText:
                                            locationController.text.isNotEmpty
                                                ? ""
                                                : "Select Location",
                                        hintText: "Select Location",
                                        filled: false,
                                        labelStyle: const TextStyle(
                                            color: textInputLabelColor,
                                            fontWeight: FontWeight.w500),
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: textInputHintColor),
                                      ),
                                    ),
                                  ),
            
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  //sort by
                                  const BasicText(
                                    text: "Sort By",
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
            
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      border: Border.all(
                                        color: kSecondaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const BasicText(
                                          text: "Most Viewed",
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.normal),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<PropertyFilterBloc>()
                                                .add(OnSortTypeSelected(
                                                    selectedId:
                                                        "MostViewd-ASC"));
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 6.0),
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16.0,
                                                    vertical: 2.0),
                                            decoration: BoxDecoration(
                                              color: state
                                                          .propertyFilter
                                                          .sortBy
                                                          .selectedId ==
                                                      "MostViewd-ASC"
                                                  ? kPrimaryColor
                                                  : Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons
                                                    .keyboard_double_arrow_up_outlined,
                                                color: state
                                                            .propertyFilter
                                                            .sortBy
                                                            .selectedId ==
                                                        "MostViewd-ASC"
                                                    ? Colors.white
                                                    : kSecondaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<PropertyFilterBloc>()
                                                .add(OnSortTypeSelected(
                                                    selectedId:
                                                        "MostViewd-DESC"));
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 6.0),
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16.0,
                                                    vertical: 2.0),
                                            decoration: BoxDecoration(
                                              color: state
                                                          .propertyFilter
                                                          .sortBy
                                                          .selectedId ==
                                                      "MostViewd-DESC"
                                                  ? kPrimaryColor
                                                  : Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons
                                                    .keyboard_double_arrow_down_outlined,
                                                color: state
                                                            .propertyFilter
                                                            .sortBy
                                                            .selectedId ==
                                                        "MostViewd-DESC"
                                                    ? Colors.white
                                                    : kSecondaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
            
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  //Amenities
                                  const BasicText(
                                    text: "Amenities",
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BlocProvider(
                                    create: (context) => AmenitiesBloc(
                                        getIt<GetAmenityList>()),
                                    child: AmenitiesSelection(
                                      selectedAmenities: state
                                          .propertyFilter.selectedAmenities,
                                      onAmenitiesSelected: (amenities) {
                                        context
                                            .read<PropertyFilterBloc>()
                                            .add(OnAmenitiesReceived(
                                                amenities: amenities));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
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
                context.read<PropertyFilterBloc>().add(OnFilterClearClicked());
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
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pop(context, propertyFilter);
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

Future<PlaceDetail?> _handleLocationSearch(BuildContext context) async {
  // show input autocomplete with selected mode
  // then get the Prediction selected
  Prediction? p = await PlacesAutocomplete.show(
    context: context,
    apiKey: kGoogleApiKey,
    onError: onError,
    mode: Mode.fullscreen,
    language: "en",
    //components: [Component(Component.country, "IN")],
  );
  if (p != null) {
    debugPrint("Prediction result: ${p.toString()}");
    PlaceDetail? placeDetail = await displayPrediction(p);
    debugPrint("location2: ${placeDetail.toString()}");
    return placeDetail;
  }
  return null;
}

Future<PlaceDetail?> displayPrediction(Prediction p) async {
  if (p.placeId != null) {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);

    var placeId = p.placeId;
    double lat = detail.result.geometry?.location.lat ?? 0.0;
    double lng = detail.result.geometry?.location.lng ?? 0.0;
    PlaceDetail location = PlaceDetail(
        address: p.description ?? "Unknown", lattitude: lat, longitude: lng);
    debugPrint("location1: ${location.toString()}");
    return location;
  }
}
