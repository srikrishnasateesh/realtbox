import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/domain/entity/amenity.dart';
import 'package:realtbox/presentation/amenities/bloc/amenities_bloc.dart';

class AmenitiesSelection extends StatelessWidget {
  final Function(List<Amenity>) onAmenitiesSelected;
  final List<Amenity> selectedAmenities;
  const AmenitiesSelection({
    super.key,
    required this.onAmenitiesSelected,
    required this.selectedAmenities,
  });

  @override
  Widget build(BuildContext context) {
    BlocListener<AmenitiesBloc, AmenitiesState>(listener: (context, state) {
      if (state is AmenitiesSelectedList) {
        final list = state.amenitiesSelected;
        //final stringList = list.map((e) => e.name).toList();
        onAmenitiesSelected(list);
      }
    });
    BlocProvider.of<AmenitiesBloc>(context).add(AmenitiesRequested(
      amenitiesSelected: selectedAmenities
    ));
    return BlocBuilder<AmenitiesBloc, AmenitiesState>(
      builder: (context, state) {
        if (state is AmenitiesLoaded) {
          final selectedList = state.amenitiesSelected;
          onAmenitiesSelected(selectedList);
          return SizedBox(
            //height: 150,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 10,
              ),
              itemCount: state.amenities.length,
              itemBuilder: (context, index) {
                //return Text(state.amenities[index].name);
                final amenity = state.amenities[index];
                bool selected = selectedList.contains(amenity);
                return InkWell(
                  onTap: () {
                    context
                        .read<AmenitiesBloc>()
                        .add(AmenitySelected(selectedAmenity: amenity));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: selected ? kPrimaryColor : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        amenity.name,
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
