import 'package:demo_app/controllers/map_controller.dart' as custom;
import 'package:demo_app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final custom.MapController mapController = Get.find<custom.MapController>();
    Size size = MediaQuery.of(context).size;
    return FloatingActionButton(
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.white,
      shape: const ContinuousRectangleBorder(
        side: BorderSide(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(65),
        ),
      ),
      onPressed: () async {
        final currentLocation = await LocationService.getCurrentLocation();
        if (mapController.currentLocation.value != null) {
          mapController.setCurrentLocation(currentLocation);
          // mapController.moveToLocation(currentLocation);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            color: Colors.blue.shade700,
          ),
          SizedBox(
            width: size.width * 0.015,
          ),
          Text(
            "Use current location",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.blue.shade700, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
