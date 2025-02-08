import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/domain/entity/property/property.dart';

class NetWorkImageList extends StatelessWidget {
  // List of image URLs
  final List<Doc> imageUrls;

  const NetWorkImageList({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageUrls.length, // Number of items (image URLs) in the list
      itemBuilder: (context, index) {
        final doc = imageUrls[index];
        return Card(
          color: Colors.white,
          shadowColor: kPrimaryColor,
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Displaying image from the network
                doc.isImage
                    ? Image.network(
                        doc.objectUrl, // Fetch the image from the network
                        loadingBuilder: (context, child, progress) {
                          if (progress == null)
                            return child; // Image loaded, show it
                          // While the image is loading, show a circular progress indicator
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          // Handle image loading error
                          return const Center(
                              child: Text('Image failed to load'));
                        },
                        fit: BoxFit
                            .cover, // Ensure the image covers the available space
                      )
                    : Column(children: [
                        const Center(
                          child: Icon(
                            Icons.picture_as_pdf,
                            size: 200,
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: () {
                            Object args = {"url": doc.objectUrl};
                            Navigator.pushNamed(context, RouteNames.viewPdf,
                                arguments: args);
                          },
                          icon: const Icon(Icons.remove_red_eye_sharp),
                          label: const Text('View'),
                          iconAlignment: IconAlignment.end,
                          style: FilledButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: Colors.white,
                          ),
                        )
                      ]),
                const SizedBox(height: 10), // Space between images
              ],
            ),
          ),
        );
      },
    );
  }
}
