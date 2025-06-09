import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/presentation/widgets/shimmer.dart';

Widget listShimmer() {
  return Expanded(
    child: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.grey.shade300,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: const ShimmerWidget.rectangular(
                            height: 150, width: double.infinity),
                      ),
                      const Positioned(
                        top: 10,
                        right: 10,
                        child: ShimmerWidget.circular(height: 30, width: 30),
                      )
                    ],
                  ),
                 Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //name,loc,price
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ShimmerWidget.rectangular(height: 20, width: 150),
                              ShimmerWidget.rectangular(height: 30, width: 150),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const ShimmerWidget.rectangular(height: 20, width: 150),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(locationPinSvg),
                              const SizedBox(width: 8.0),
                              const Expanded(
                                child: ShimmerWidget.rectangular(
                                    height: 20, width: 150),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
