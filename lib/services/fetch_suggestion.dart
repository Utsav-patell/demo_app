import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class FetchSuggestion {
  static Future<List<String>> fetchPlaceSuggestions(String query) async {
    if (query.isEmpty) return [];
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1');
    final response = await http.get(url);
    log(response.toString());

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((place) => place['display_name'] as String).toList();
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  static Future<LatLng?> getPlaceCoordinates(String placeDescription) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$placeDescription&format=json&addressdetails=1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      // Check if we got results
      if (data.isNotEmpty) {
        final location = data[0];
        final lat = double.parse(location['lat']);
        final lng = double.parse(location['lon']);

        // Return the coordinates as LatLng
        return LatLng(lat, lng);
      }
    }
    return null; // In case of no data or an error
  }
}
