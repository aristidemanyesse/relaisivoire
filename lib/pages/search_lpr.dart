import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/pages/distance_map.dart';
import 'package:lpr/pages/map_button.dart';

class SearchLPR extends StatelessWidget {
  SearchLPR({
    super.key,
  });

  Random rnd = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.size.height,
            width: double.infinity,
            child: Stack(
              children: [
                FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(5.316667, -4.033333),
                    initialZoom: 16,
                    minZoom: 6,
                    maxZoom: 20,
                  ),
                  children: [
                    TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'dev.fleaflet.flutter_map.example',
                        subdomains: const ['mt0', 'mt1', 'mt2', 'mt3']),
                    PopupMarkerLayer(
                      options: PopupMarkerLayerOptions(
                        markers: List.generate(
                            5,
                            (index) => Marker(
                                  point: LatLng(rnd.nextDouble() + 5.916667,
                                      -rnd.nextDouble() + (-4.033333)),
                                  width: 40,
                                  height: 40,
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Icon(
                                      Icons.location_pin,
                                      size: 27,
                                      color: MyColors.danger,
                                    ),
                                  ),
                                )).toList(),
                        popupDisplayOptions: PopupDisplayOptions(
                            builder: (BuildContext context, Marker marker) {
                          return Container(child: const Text("."));
                        }),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SafeArea(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: Tools.PADDING / 2),
              child: Column(
                children: [
                  SizedBox(
                    height: Tools.PADDING / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      const Expanded(
                        child: TextField(
                          style: TextStyle(fontSize: 15.0),
                          scrollPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 20.0),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Rechercher un lieu',
                            hintStyle: TextStyle(
                                fontSize:
                                    15.0), // Taille de la police du hint text réduite
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyColors.primary, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyColors.primary, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Tools.PADDING / 2,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Tools.PADDING / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DistanceMap(text: "1 Km"),
                        DistanceMap(text: "2 Km"),
                        DistanceMap(text: "5 Km"),
                        DistanceMap(text: "10 Km"),
                        GestureDetector(
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                            child: Center(child: Icon(Icons.list)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: Tools.PADDING,
            right: Tools.PADDING,
            child: Column(
              children: [
                MapButton(
                  widget: Icon(Icons.assistant_navigation, size: 30),
                ),
                const SizedBox(
                  height: Tools.PADDING / 2,
                ),
                MapButton(
                  widget: Icon(Icons.my_location, size: 30),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
