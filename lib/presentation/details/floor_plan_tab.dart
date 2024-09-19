import 'package:flutter/material.dart';
import 'package:realtbox/presentation/widgets/image_list_network.dart';

class FloorPlanTab extends StatelessWidget {
  // List of image URLs
  final List<String> imageUrls;
  const FloorPlanTab({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetWorkImageList(imageUrls: imageUrls),
    );
  }
}
