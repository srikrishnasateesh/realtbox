import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/data/model/amenities/amenity-list-dto.dart';
import 'package:realtbox/domain/entity/amenity.dart';
class AmenitiesTab extends StatelessWidget {
  final List<AmenityData> amenityList;
  const AmenitiesTab({super.key, required this.amenityList});

  @override
  Widget build(BuildContext context) {
     return amenityList.isNotEmpty ? SingleChildScrollView(
       child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 60.0, // Spacing between items horizontally
                  runSpacing: 16.0, // Spacing between items vertically
                  children: amenityList.map((amenity) {
                    
                    return Container(
                      width: 150, // Adjust width as per requirement
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            amenity.icon ?? "",
                            width: 20,
                            height: 20,
                            color:  kSecondaryColor,
                          ),
                          Text(
                            amenity.name ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color:  Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
     ) : const Center(child: Text('No data found'));
        
  }
}