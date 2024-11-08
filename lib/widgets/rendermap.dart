// widgets/map_view.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

import '../controllers/map_controller.dart' as custom;

class Rendermap extends StatefulWidget {
  const Rendermap({super.key});

  @override
  State<Rendermap> createState() => _RendermapState();
}

class _RendermapState extends State<Rendermap> {
  final MapController flutterMapController = MapController();
  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    // Use Custom.MapController explicitly
    final custom.MapController mapController = Get.find<custom.MapController>();

    return Obx(
      () {
        return Stack(
          children: [
            mapController.currentLocation.value == null
                ? const Center(child: CircularProgressIndicator())
                : FlutterMap(
                    // mapController: flutterMapController,
                    options: MapOptions(
                      initialCenter: mapController.currentLocation.value!,
                      initialZoom: 16,
                      maxZoom: 18,
                      minZoom: 15,
                      onPositionChanged: (position, hasGesture) {
                        if (hasGesture) {
                          _debounceTimer?.cancel();

                          _debounceTimer = Timer(
                            const Duration(seconds: 1),
                            () {
                              mapController.setCurrentLocation(position.center);
                              mapController.updateAddress(position.center);
                            },
                          );
                        }
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      ),
                      CircleLayer(
                        circles: [
                          CircleMarker(
                            point: mapController.currentLocation.value!,
                            color: Colors.blue
                                .withOpacity(0.3), // Circle color with opacity
                            borderStrokeWidth: 2, // Border stroke
                            borderColor: Colors.blue, // Border color
                            radius: 55, // Radius in meters
                          ),
                        ],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: mapController.currentLocation.value!,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _debounceTimer?.cancel();
    super.dispose();
  }
}
