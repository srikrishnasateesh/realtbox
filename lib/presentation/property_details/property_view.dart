import 'dart:async';

import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/core/utils/price-fromatter.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';

class PropertyView extends StatefulWidget {
  final Property property;
  final int activePage;
  const PropertyView({
    super.key,
    required this.property,
    this.activePage = 0,
  });

  @override
  State<PropertyView> createState() => _PropertyViewState();
}

int _activePage = 0;
Timer? timer;

class _PropertyViewState extends State<PropertyView> {
  PageController pageController = PageController();
  List<String> imageUrls = List.empty();
  @override
  void initState() {
    super.initState();
    _activePage = widget.activePage;
    imageUrls = widget.property.images.map((e) => e.objectUrl).toList();
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
    final size = MediaQuery.of(context).size;
    final property = widget.property;

    List<String> amnities = property.amenities.map((e)=>e.name??"").toList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Property Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: kSecondaryColor, spreadRadius: 1),
              ],
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: size.height / 3,
                          width: double.infinity,
                          child: PageView.builder(
                            physics: ClampingScrollPhysics(),
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
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  imageUrls[index],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      imageUrls.length>1 ?  Positioned(
                          left: 0,
                          bottom: 10,
                          right: 0,
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  imageUrls.length,
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: InkWell(
                                          child: CircleAvatar(
                                            radius: 4,
                                            backgroundColor:
                                                _activePage == index
                                                    ? kPrimaryColor
                                                    : Colors.grey,
                                          ),
                                        ),
                                      )),
                            ),
                          ),
                        ) : Container()
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 30,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: kPrimaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: kSecondaryColor,
                                          spreadRadius: 0),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const BasicText(
                                          textAlign: TextAlign.center,
                                          text: 'Asset Value',
                                          textStyle: TextStyle(
                                            color: kSecondaryColor,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        BasicText(
                                          textAlign: TextAlign.center,
                                          text:
                                              "\u{20B9} ${formatStringPrice(property.price)}",
                                          textStyle: const TextStyle(
                                            color: kSecondaryColor,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 45,
                                child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: kSecondaryColor,
                                            spreadRadius: 1),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const BasicText(
                                            text: 'Additional Features',
                                            textStyle: TextStyle(
                                              color: kSecondaryColor,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 150,
                                            child: SingleChildScrollView(
                                              child: GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 2,
                                                  mainAxisSpacing: 8,
                                                  crossAxisSpacing: 8,
                                                ),
                                                itemCount: amnities.length,
                                                itemBuilder:
                                                    (context, index) {
                                                  return Text(
                                                      amnities[index]);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 5),
                          child: Container(
                            width: size.width,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: lightgrey,
                              boxShadow: [
                                BoxShadow(
                                    color: kSecondaryColor,
                                    spreadRadius: 0.5),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BasicText(
                                    text: property.projectName,
                                    textStyle: const TextStyle(
                                      color: kSecondaryColor,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  BasicText(
                                    text: property.description,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*  /* Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: amnities
                                        .map(
                                          (feature) => Text(feature),
                                        )
                                        .toList(),
                                  ), */ */