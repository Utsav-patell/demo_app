import 'package:demo_app/services/location_service.dart';
import 'package:demo_app/widgets/custom_search_bar.dart';
import 'package:demo_app/widgets/floating_button.dart';
import 'package:demo_app/widgets/floating_container.dart';
import 'package:demo_app/widgets/rendermap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/map_controller.dart' as custom;

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(custom.MapController(), permanent: true);
    LocationService.getCurrentLocation().then(
      (location) {
        if (mapController.currentLocation.value == null) {
          mapController.setCurrentLocation(location);
        }
      },
    );
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        const Rendermap(),
        Positioned(
          bottom: 0,
          width: size.width,
          height: size.height * 0.25,
          child: const FloatingContainer(),
        ),
        Positioned(
          width: size.width * 0.9,
          top: size.height * 0.03,
          child: const CustomSearchBar(),
        ),
        Positioned(
          right: size.width * 0.04,
          bottom: size.height * 0.26,
          width: size.width * 0.45,
          height: size.height * 0.045,
          child: const FloatingButton(),
        ),
      ],
    );
  }
}
