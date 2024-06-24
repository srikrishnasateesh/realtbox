import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/presentation/propert_type/cubit/property_type_cubit.dart';

class HorizontalCategoryTypes extends StatelessWidget {
  final Function(String) onCategoryChanged;
  const HorizontalCategoryTypes({super.key, required this.onCategoryChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<PropertyTypeCubit, PropertyTypeState>(
        builder: (context, state) {
          debugPrint("State:$state");
          /*if (state.status == PropertyTypeStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status == PropertyTypeStatus.error) {
            return Center(child: Text('Failed to load property types'));
          } else  */
          if (state.status == PropertyTypeStatus.loaded) {
            onCategoryChanged(state.propertyTypes[state.selectedIndex].key);
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.propertyTypes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.read<PropertyTypeCubit>().selectPropertyType(index);
                    //onCategoryChanged(state.propertyTypes[index].key);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: state.selectedIndex == index
                          ? kPrimaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        state.propertyTypes[index].displayName,
                        style: TextStyle(
                          color: state.selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
