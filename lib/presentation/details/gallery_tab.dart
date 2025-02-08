import 'package:flutter/material.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/presentation/widgets/image_list_network.dart';

class GalleryTab extends StatelessWidget {
  // List of image URLs
  final List<Doc> imageUrls;

  GalleryTab({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetWorkImageList(imageUrls: imageUrls),
    );
  }
}
