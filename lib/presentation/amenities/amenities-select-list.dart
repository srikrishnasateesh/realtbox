import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/domain/entity/amenity.dart';
import 'package:realtbox/presentation/amenities/bloc/amenities_bloc.dart';

class AmenitiesSelection extends StatelessWidget {
  final Function(List<Amenity>) onAmenitiesSelected;
  final List<Amenity> selectedAmenities;
  bool selectable;
   AmenitiesSelection({
    super.key,
    required this.onAmenitiesSelected,
    required this.selectedAmenities,
    this.selectable = true,
  });

  @override
  Widget build(BuildContext context) {
    BlocListener<AmenitiesBloc, AmenitiesState>(listener: (context, state) {
      if (state is AmenitiesSelectedList) {
        final list = state.amenitiesSelected;
        onAmenitiesSelected(list);
      }
    });
    BlocProvider.of<AmenitiesBloc>(context).add(AmenitiesRequested(
      amenitiesSelected: selectedAmenities,
    ));

    return BlocBuilder<AmenitiesBloc, AmenitiesState>(
      builder: (context, state) {
        if (state is AmenitiesLoaded) {
          final selectedList = state.amenitiesSelected;
          onAmenitiesSelected(selectedList);
          return Center(
            child: SizedBox(
              child: Wrap(
                spacing: 8.0, // Spacing between items horizontally
                runSpacing: 16.0, // Spacing between items vertically
                children: state.amenities.map((amenity) {
                  bool selected = selectedList.contains(amenity);
                  return InkWell(
                    onTap: () {
                      if(selectable){
                      context
                          .read<AmenitiesBloc>()
                          .add(AmenitySelected(selectedAmenity: amenity));
                      }
                    },
                    child: Container(
                     width: (MediaQuery.of(context).size.width)/2.5, // Adjust width as per requirement
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: selected ? kPrimaryColor : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            amenity.icon,
                            width: 20,
                            height: 20,
                            color: selected ? Colors.white : kSecondaryColor,
                          ),
                          Text(
                            amenity.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
