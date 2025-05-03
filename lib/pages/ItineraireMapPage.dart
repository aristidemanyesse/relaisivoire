import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/models/PointRelaisApp/PointRelais.dart';
import 'package:lpr/pages/map_button.dart';
import 'package:lpr/services/LoactionService.dart';

class ItineraireMapPage extends StatefulWidget {
  final List<PointRelais> listePointsRelais;

  const ItineraireMapPage({super.key, required this.listePointsRelais});

  @override
  State<ItineraireMapPage> createState() => _ItineraireMapPageState();
}

class _ItineraireMapPageState extends State<ItineraireMapPage> {
  GeneralController controller = Get.find();
  final Completer<GoogleMapController> _controller = Completer();
  Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};
  List<Map<String, dynamic>> _directionsSteps = [];
  LatLng? _userLocation;
  String? _durationText;
  String? _distanceText;
  bool _mapCreated = false;
  late StreamSubscription<Position> _positionSubscription;
  bool _isNavigating = false;
  BitmapDescriptor? _navigationIcon;
  StreamSubscription<CompassEvent>? _compassSubscription;
  double _currentHeading = 0;

  String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;

    if (hours > 0) {
      return "$hours h $minutes min";
    } else {
      return "$minutes min";
    }
  }

  String formatDistance(int meters) {
    if (meters >= 1000) {
      return "${(meters / 1000).toStringAsFixed(1)} km";
    } else {
      return "$meters m";
    }
  }

  @override
  void initState() {
    super.initState();
    _userLocation = LatLng(
      controller.position.value!.latitude,
      controller.position.value!.longitude,
    );

    _startEverything();
  }

  Future<void> _loadNavigationIcon() async {
    _navigationIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(80, 80)),
      'assets/icons/navigation.png',
    );
  }

  Future<void> _startEverything() async {
    await _getCurrentPosition();
    _addRelaisMarkers();
    await _getMultiStopDirections();
    _startListeningToPosition(); // 🟢 Activation du mode temps réel
  }

  void _startListeningToPosition() {
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      _onPositionChanged(position);
    });
  }

  Future<void> _onPositionChanged(Position position) async {
    final current = LatLng(position.latitude, position.longitude);

    setState(() {
      _userLocation = current;
    });

    // 🟡 Mise à jour du marker utilisateur
    _markers.removeWhere((m) => m.markerId.value == 'user_nav');
    _markers.add(
      Marker(
        markerId: const MarkerId('user_nav'),
        position: current,
        infoWindow: const InfoWindow(title: "Vous êtes ici"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );

    await _getMultiStopDirections(); // 🧠 recalcul dynamique
  }

  Future<void> _getCurrentPosition() async {
    _markers.add(
      Marker(
        markerId: const MarkerId('user_nav'),
        position: _userLocation ?? LatLng(0, 0),
        infoWindow: const InfoWindow(title: "Vous êtes ici"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );
  }

  void _startCompass() {
    _compassSubscription = FlutterCompass.events!.listen((compass) {
      setState(() {
        _currentHeading = compass.heading ?? 0;
      });

      // MAJ du marker pour la rotation même à l’arrêt
      if (_userLocation != null && _isNavigating) {
        _markers.removeWhere((m) => m.markerId.value == 'user_nav');

        _markers.add(
          Marker(
            markerId: const MarkerId('user_nav'),
            position: _userLocation!,
            rotation: _currentHeading,
            anchor: const Offset(0.5, 0.5),
            flat: true,
            icon: _navigationIcon ?? BitmapDescriptor.defaultMarker,
          ),
        );
      }
    });
  }

  Future<void> _startNavigationMode() async {
    _isNavigating = true;
    _startCompass();
    await _loadNavigationIcon();
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 5,
      ),
    ).listen((position) async {
      final controller = await _controller.future;
      final current = LatLng(position.latitude, position.longitude);
      final heading = (position.heading != -1) ? position.heading : 0;

      setState(() {
        _userLocation = current;
        _checkStepProgress(_userLocation!);

        // Retire ancien marker
        _markers.removeWhere((m) => m.markerId.value == 'user_nav');

        // Ajoute un marker avec rotation vers heading
        _markers.add(
          Marker(
            markerId: const MarkerId('user_nav'),
            position: current,
            icon: _navigationIcon ?? BitmapDescriptor.defaultMarker,
            rotation: _currentHeading,
            anchor: const Offset(0.5, 0.5),
            flat: true,
          ),
        );
      });

      // Déplace la caméra comme avant
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: current,
            zoom: 18,
            tilt: 40,
            bearing: _currentHeading,
          ),
        ),
      );
    });
  }

  Future<void> _jumpToCurrentPosition() async {
    if (_userLocation == null) return;
    final controller = await _controller.future;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _userLocation!,
          zoom: 18,
          tilt: 40,
          bearing: _currentHeading, // tu peux aussi simuler un heading ici
        ),
      ),
    );
  }

  Future<void> _resetCameraView() async {
    if (_userLocation == null) return;

    final controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _userLocation!, zoom: 15, tilt: 0, bearing: 0),
      ),
    );
  }

  void _stopNavigationMode() {
    _positionSubscription.cancel();
    _compassSubscription?.cancel(); // 🧭 stop compass
    _isNavigating = false;

    _markers.removeWhere((m) => m.markerId.value == 'user_nav');

    _markers.add(
      Marker(
        markerId: const MarkerId('user_nav'),
        position: _userLocation!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(title: "Vous êtes ici"),
      ),
    );
  }

  void _addRelaisMarkers() {
    for (int i = 0; i < widget.listePointsRelais.length; i++) {
      final pr = widget.listePointsRelais[i];
      final LatLng position = LatLng(pr.latitude!, pr.longitude!);

      _markers.add(
        Marker(
          markerId: MarkerId('relais_$i'),
          position: position,
          infoWindow: InfoWindow(
            title: pr.libelle,
            snippet: '📍 ${pr.adresse}\n⏱️ Durée estimée à l’arrivée',
          ),
        ),
      );
    }
  }

  Future<void> _getMultiStopDirections() async {
    if (_userLocation == null || widget.listePointsRelais.isEmpty) return;

    final origin = _userLocation!;
    final destination = LatLng(
      widget.listePointsRelais.last.latitude!,
      widget.listePointsRelais.last.longitude!,
    );

    final waypoints = widget.listePointsRelais
        .sublist(0, widget.listePointsRelais.length - 1)
        .map((p) => '${p.latitude},${p.longitude}')
        .join('|');

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
      '?origin=${origin.latitude},${origin.longitude}'
      '&destination=${destination.latitude},${destination.longitude}'
      '&waypoints=$waypoints'
      '&mode=driving'
      '&language=fr'
      '&key=${LocationService.APIKEY}',
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (data['status'] != 'OK') {
        print('❌ API Directions error: ${data['status']}');
        return;
      }

      final route = data['routes'][0];
      final legs = route['legs'] as List<dynamic>;

      // Totaux
      int totalDurationSecs = 0;
      int totalDistanceMeters = 0;

      for (var leg in legs) {
        totalDurationSecs += int.parse(
          leg['duration']['value'].toString(),
        ); // en secondes
        totalDistanceMeters += int.parse(
          leg['distance']['value'].toString(),
        ); // en mètres
      }

      List<Map<String, dynamic>> allSteps = [];

      for (int i = 0; i < legs.length; i++) {
        final leg = legs[i];
        final steps = leg['steps'] as List<dynamic>;

        allSteps.addAll(
          steps.map((step) {
            final lat = step['end_location']['lat'];
            final lng = step['end_location']['lng'];
            return {
              'instruction': _cleanHtml(step['html_instructions']),
              'distance': step['distance']['text'],
              'type': 'step',
              'location': LatLng(lat, lng), // ✅ Coordonnées de fin de step
            };
          }),
        );

        // Intermédiaire : arrivé chez PR
        if (i < widget.listePointsRelais.length) {
          final pr = widget.listePointsRelais[i];
          allSteps.add({
            'instruction': '🟢 Arrivé chez ${pr.libelle}',
            'distance': '',
            'type': 'arrivee',
            'location': LatLng(pr.latitude!, pr.longitude!), // ✅ aussi localisé
          });
        }
      }

      setState(() {
        _durationText = formatDuration(totalDurationSecs);
        _distanceText = formatDistance(totalDistanceMeters);
        _directionsSteps = allSteps;

        _polylines = {
          Polyline(
            polylineId: const PolylineId("itineraire"),
            color: Colors.blue,
            width: 8,
            points: _decodePolyline(route['overview_polyline']['points']),
          ),
        };
      });
    } catch (e) {
      print("❌ Erreur Directions API: $e");
    }
  }

  String _cleanHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&');
  }

  void _checkStepProgress(LatLng current) {
    if (_directionsSteps.isEmpty) return;

    final nextStep = _directionsSteps.first;

    if (!nextStep.containsKey('location')) return;

    final LatLng stepLoc = nextStep['location'];
    final distance = Geolocator.distanceBetween(
      current.latitude,
      current.longitude,
      stepLoc.latitude,
      stepLoc.longitude,
    );

    if (distance < 30) {
      print("✅ Étape franchie : ${nextStep['instruction']}");
      setState(() {
        _directionsSteps.removeAt(0);
      });
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
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

  Future<void> _fitBounds() async {
    final controller = await _controller.future;
    final positions = widget.listePointsRelais
        .map((e) => LatLng(e.latitude!, e.longitude!))
        .toList();
    positions.add(_userLocation!);
    final bounds = _boundsFromLatLngList(positions);
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));
  }

  Future<void> _locateMe() async {
    try {
      final controller = await _controller.future;

      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _userLocation!, zoom: 18),
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

  @override
  void dispose() {
    _positionSubscription.cancel();
    _compassSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: Text(
          "Mon itinéraire de course",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: MyColors.secondary,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: MyColors.secondary),
        ),
      ),
      body: _userLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(height: 30, child: Wave()),
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _userLocation!,
                          zoom: 14,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        markers: _markers,
                        polylines: _polylines,
                        onMapCreated: (GoogleMapController controller) {
                          if (!_mapCreated) {
                            _controller.complete(controller);
                            _mapCreated = true;
                          }
                        },
                      ),
                      if (_durationText != null && _distanceText != null)
                        Positioned(
                          top: 20,
                          left: 20,
                          right: 20,
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.directions_car,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(_distanceText!),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_sharp,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "${widget.listePointsRelais.length} Points relais",
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(_durationText!),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (_directionsSteps.isNotEmpty)
                        DraggableScrollableSheet(
                          initialChildSize: 0.2, // taille au démarrage (2%)
                          minChildSize: 0.2, // taille minimale possible
                          maxChildSize:
                              0.5, // taille max que l’utilisateur peut glisser
                          builder: (context, scrollController) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MapButton(
                                      widget: Icon(
                                        color: MyColors.danger,
                                        _isNavigating
                                            ? Icons.close
                                            : Icons.navigation,
                                        size: 30,
                                      ),
                                      onTap: () async {
                                        if (_isNavigating) {
                                          _stopNavigationMode();
                                          await _resetCameraView(); // 🔁 retour à une vue normale
                                        } else {
                                          await _startNavigationMode(); // suivi dynamique avec orientation
                                          await _jumpToCurrentPosition(); // centrage immédiat
                                        }
                                        setState(() {});
                                      },
                                    ),
                                    const SizedBox(width: Tools.PADDING),
                                    MapButton(
                                      widget: const Icon(
                                        Icons.center_focus_strong,
                                        size: 30,
                                      ),
                                      onTap: _fitBounds,
                                    ),
                                    const SizedBox(width: Tools.PADDING),
                                    MapButton(
                                      widget: const Icon(
                                        Icons.my_location,
                                        size: 30,
                                      ),
                                      onTap: _locateMe,
                                    ),
                                    const SizedBox(width: Tools.PADDING / 2),
                                  ],
                                ),
                                SizedBox(height: Tools.PADDING / 2),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Colors.black26,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 5,
                                          margin: const EdgeInsets.only(
                                            bottom: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        const Text(
                                          "🗺️ Étapes de navigation",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Expanded(
                                          child: ListView.builder(
                                            controller:
                                                scrollController, // important !
                                            itemCount: _directionsSteps.length,
                                            itemBuilder: (context, index) {
                                              final step =
                                                  _directionsSteps[index];
                                              final isArrival =
                                                  step['type'] == 'arrivee';

                                              return ListTile(
                                                selected: isArrival,
                                                selectedColor: Colors.green,
                                                leading: Icon(
                                                  isArrival
                                                      ? Icons.location_on
                                                      : Icons.directions,
                                                  color: isArrival
                                                      ? Colors.green
                                                      : Colors.blue,
                                                ),
                                                title: Text(
                                                  step['instruction'],
                                                  style: TextStyle(
                                                    fontWeight: isArrival
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                    color: isArrival
                                                        ? Colors.green
                                                        : Colors.black,
                                                  ),
                                                ),
                                                trailing: step['distance'] != ''
                                                    ? Text(
                                                        step['distance'],
                                                      )
                                                    : null,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
