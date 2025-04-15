import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/controllers/HandleTypesController.dart';
import 'package:lpr/models/PointRelaisApp/PointRelais.dart';
import 'package:lpr/pages/distance_map.dart';
import 'package:lpr/pages/map_button.dart';
import 'package:lpr/services/LoactionService.dart';

class SearchLPR extends StatefulWidget {
  final List<PointRelais> pointsRelais;
  SearchLPR({
    super.key,
    required this.pointsRelais,
  });

  @override
  State<SearchLPR> createState() => _SearchLPRState();
}

class _SearchLPRState extends State<SearchLPR> {
  GeneralController generalController = Get.find();
  HandleTypesController controller = Get.find();

  Random rnd = Random();
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  Set<Circle> _circles = {};
  LatLng? _currentPosition;
  BitmapDescriptor? _customMarkerIcon;

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

  Future<void> _loadMarkerIcon() async {
    _customMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      "assets/icons/marker_relais.png",
    );
  }

  void _setMarkers() {
    for (var point in widget.pointsRelais) {
      final marker = Marker(
        markerId: MarkerId("relais-${point.id}"),
        position: LatLng(point.latitude!, point.longitude!),
        infoWindow: InfoWindow(
          title: point.libelle,
          snippet: point.adresse(),
        ),
        icon: _customMarkerIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
      _markers.add(marker);
    }
    setState(() {});
  }

  Future<void> _initMap() async {
    try {
      setState(() {
        _currentPosition = LatLng(5.3251, -4.0124);
        // _currentPosition = LatLng(generalController.position.value!.latitude, generalController.position.value!.longitude);
      });
      _setMarkers();
      WidgetsBinding.instance.addPostFrameCallback((_) => _fitBounds());
    } catch (e) {
      print("❌ Impossible de récupérer la position : $e");
    }
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  Future<void> _locateMe() async {
    try {
      final position = await LocationService.getCurrentPosition();
      final LatLng current = LatLng(position!.latitude, position!.longitude);

      final controller = await _controller.future;
      setState(() {
        _circles = {
          Circle(
            circleId: const CircleId("user-circle"),
            center: current,
            radius: 100, // Rayon en mètres
            strokeWidth: 2,
            strokeColor: Colors.blue,
            fillColor: Colors.blue.withOpacity(0.15),
          ),
        };
      });

      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: current, zoom: 17),
        ),
      );
    } catch (e) {
      print("❌ Erreur de localisation : $e");
      Get.snackbar(
        "Erreur de localisation",
        "Impossible de récupérer votre position",
        colorText: Colors.white,
        backgroundColor: MyColors.primary,
      );
    }
  }

  Future<void> _fitBounds() async {
    if (widget.pointsRelais.isEmpty) return;

    final controller = await _controller.future;
    final positions = widget.pointsRelais
        .map((e) => LatLng(e.latitude!, e.longitude!))
        .toList();
    final bounds = boundsFromLatLngList(positions);

    CameraUpdate update = CameraUpdate.newLatLngBounds(bounds, 60);
    controller.animateCamera(update);
  }

  void _moveToFitAll() async {
    List<LatLng> pointsRelais = [
      LatLng(5.34, -4.02),
      LatLng(5.37, -4.04),
      LatLng(5.36, -4.00),
    ];
    final controller = await _controller.future;
    final bounds = boundsFromLatLngList(pointsRelais);
    final update = CameraUpdate.newLatLngBounds(bounds, 50);
    controller.animateCamera(update);
  }

  @override
  void initState() {
    _initMap();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _moveToFitAll());
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
                  myLocationButtonEnabled: false,
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
            bottom: Tools.PADDING * 2,
            right: Tools.PADDING,
            child: Column(
              children: [
                MapButton(
                  widget: Icon(Icons.center_focus_strong, size: 30),
                  onTap: _fitBounds,
                ),
                const SizedBox(
                  height: Tools.PADDING,
                ),
                MapButton(
                  widget: Icon(Icons.my_location, size: 30),
                  onTap: _locateMe,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
