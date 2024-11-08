import 'package:demo_app/services/fetch_suggestion.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../controllers/map_controller.dart' as custom;

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    final mapController = Get.find<custom.MapController>();
    return TypeAheadField(
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: const InputDecoration(
              label: Text(
                "Search Places",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              prefixIcon: Icon(Icons.search),
              fillColor: Colors.white,
              filled: true),
        );
      },
      suggestionsCallback: (search) =>
          FetchSuggestion.fetchPlaceSuggestions(search),
      itemBuilder: (context, String suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      hideOnSelect: true,
      onSelected: (String suggestion) async {
        final placeDetails =
            await FetchSuggestion.getPlaceCoordinates(suggestion);
        if (placeDetails != null) {
          mapController.setCurrentLocation(placeDetails);
        }
      },
      hideOnEmpty: true,
    );
  }
}
