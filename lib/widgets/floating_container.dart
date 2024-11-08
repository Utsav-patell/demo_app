import 'package:demo_app/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingContainer extends StatelessWidget {
  const FloatingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final mapController = Get.find<MapController>();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.03),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            Obx(() {
              if (mapController.isLoading.value) {
                // Show loading indicator
                return const CircularProgressIndicator();
              } else {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.my_location_outlined),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                          '${mapController.addressTitle.value}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      '${mapController.addressTitle.value}, ${mapController.street.value}, ${mapController.state.value} ${mapController.country.value}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: const WidgetStatePropertyAll(0.1),
                          shape: const WidgetStatePropertyAll(
                            ContinuousRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.blue.shade800),
                          textStyle: WidgetStatePropertyAll(
                            Theme.of(context).textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Confirm location",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
