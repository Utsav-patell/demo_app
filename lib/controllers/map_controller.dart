import 'dart:developer';

// import 'package:flutter_map/flutter_map.dart' as flutter;
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class MapController extends GetxController {
  // var flutterMapController = Rx<flutter.MapController?>(null);
  var currentLocation = Rxn<LatLng>();
  var addressTitle = ''.obs;
  var country = ''.obs;
  var street = ''.obs;
  var state = ''.obs;
  var pincode = ''.obs;
  var isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   flutterMapController.value = flutter.MapController();
  // }

  void updateAddress(LatLng location) async {
    isLoading.value = true;
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);

      // log("Placemark list: $placemarks");

      var placemark = placemarks.firstWhere(
        (p) => p.postalCode != null && p.locality != null,
        orElse: () => placemarks.first,
      );
      addressTitle.value = placemark.name ?? 'Unknown';
      street.value = placemark.street ?? 'Unknown';
      state.value = placemark.administrativeArea ?? 'Not Available';
      country.value = placemark.country ?? 'Unknown';
      pincode.value = placemark.postalCode ?? 'Not Available';
      log(addressTitle.value);
    } catch (e) {
      log("Error in geocoding: $e");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  void setCurrentLocation(LatLng location) {
    log("Set currentLocation");
    currentLocation.value = location;
    updateAddress(location);
  }

  // void moveToLocation(LatLng location, {double zoom = 16.0}) {
  //   if (flutterMapController.value != null) {
  //     // Move the map to the location with a zoom level
  //     flutterMapController.value!.move(location, zoom);
  //   }
  // }
}
