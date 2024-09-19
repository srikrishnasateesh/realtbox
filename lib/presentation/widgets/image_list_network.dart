import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';

class NetWorkImageList extends StatelessWidget {
  // List of image URLs
  final List<String> imageUrls;

   const NetWorkImageList({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: imageUrls.length,  // Number of items (image URLs) in the list
        itemBuilder: (context, index) {
          return Card(
            shadowColor: kPrimaryColor,
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Displaying image from the network
                  Image.network(
                    imageUrls[index], // Fetch the image from the network
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child; // Image loaded, show it
                      // While the image is loading, show a circular progress indicator
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      // Handle image loading error
                      return const Center(child: Text('Image failed to load'));
                    },
                    fit: BoxFit.cover, // Ensure the image covers the available space
                  ),
                  const SizedBox(height: 10), // Space between images
                ],
              ),
            ),
          );
        },
    );
  }
}
