import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/controllers/HandleTypesController.dart';
import 'package:lpr/pages/distance_map.dart';
import 'package:lpr/pages/map_button.dart';
import 'package:lpr/services/LoactionService.dart';

class SearchLPR extends StatefulWidget {
  SearchLPR({
    super.key,
  });

  @override
  State<SearchLPR> createState() => _SearchLPRState();
}

class _SearchLPRState extends State<SearchLPR> {
  HandleTypesController controller = Get.find();

  Random rnd = Random();
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};

  Future<void> _initMap() async {
    final position = await LocationService.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position!.latitude, position.longitude);
    });

    _loadMarkers();
  }

  void _loadMarkers() {
    for (var relais in controller.listePointsRelais.value) {
      final marker = Marker(
        markerId: MarkerId("point-${relais.id}"),
        position: LatLng(relais.latitude!, relais.longitude!),
        infoWindow: InfoWindow(
          title: relais.libelle,
          snippet: relais.adresse(),
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );

      _markers.add(marker);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.size.height,
            width: double.infinity,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 13,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
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
