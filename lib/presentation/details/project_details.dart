import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/presentation/details/details_tab.dart';
import 'package:realtbox/presentation/details/floor_plan_tab.dart';
import 'package:realtbox/presentation/details/gallery_tab.dart';
import 'package:realtbox/presentation/details/location_tab.dart';
import 'package:realtbox/presentation/details/video_tab.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';

class ProjectDetailsPage extends StatefulWidget {
  final Property property;
  final int activePage;
  const ProjectDetailsPage({
    super.key,
    required this.property,
    this.activePage = 0,
  });

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

int _activePage = 0;
Timer? timer;

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  PageController pageController = PageController();
  List<String> imageUrls = List.empty();

  @override
  void initState() {
    super.initState();
    _activePage = widget.activePage;
    imageUrls = widget.property.headerImages;
    if (imageUrls.length > 1) {
      startTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    pageController.dispose();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if ((pageController.page ?? 0) < imageUrls.length - 1) {
        pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6, // Number of tabs
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(onPressed:(){
                Navigator.pop(context);
              }, icon: SvgPicture.asset(backIosSvg,
              width: 60,
              height: 60,
              color: kPrimaryColor,)),
              title: const BasicText(
                text: 'Property Details',
                textStyle: TextStyle(color: Colors.white),
              ),
              centerTitle: false,
              pinned: true,
              floating: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                //title: const Text('Property Details'),
                background: imageUrls.isNotEmpty
                    ? PageView.builder(
                        physics: const ClampingScrollPhysics(),
                        controller: pageController,
                        itemCount: imageUrls.length,
                        onPageChanged: (value) => {
                          if (mounted)
                            {
                              setState(() {
                                _activePage = value;
                              })
                            }
                        },
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            // borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              imageUrls[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: BasicText(
                        text: widget.property.projectName.toUpperCase(),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: FontSize.s25,
                          fontWeight: FontWeight.bold
                        ),
                      )),
              ),
              bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor:
                    Colors.black54, // Text color when not selected
                labelColor: Colors.white, // Text color when selected
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.bold), // Text style
                indicator: BoxDecoration(
                  color: kPrimaryColor, // Background color of the tab
                  borderRadius: BorderRadius.circular(8),
                  /* BorderRadius.only(
                      topLeft:  Radius.circular(8.0),
                      topRight: Radius.circular(8.0)), */ // Rounded rectangle
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Shadow position
                    ),
                  ],
                ),
                tabs: const [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Tab(text: 'Property Details'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Tab(text: 'Location'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Tab(text: 'Gallery'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Tab(text: 'Floor Plan'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Tab(text: 'Videos'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Tab(text: 'Documents'),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  // Tab content for each tab
                  DetailsTab(property: widget.property,),
                  LocationTab(
                    location: widget.property.geoLocation,
                    address: widget.property.location,
                    id: widget.property.propertyId,
                    projectName: widget.property.projectName,
                  ),
                  GalleryTab(imageUrls: widget.property.images,),
                  FloorPlanTab(imageUrls: widget.property.floorImages,),
                  VideoTab(videoUrls: widget.property.videos,),
                  DocumentsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example content for each tab



class DocumentsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Documents Content'));
  }
}
