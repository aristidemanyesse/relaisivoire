import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/models/PointRelaisApp/PointRelais.dart';
import 'package:lpr/pages/distance_map.dart';
import 'package:lpr/pages/map_button.dart';
import 'package:lpr/services/LoactionService.dart';

class ItineraireMapPage extends StatefulWidget {
  final PointRelais pointRelais;

  const ItineraireMapPage({
    super.key,
    required this.pointRelais,
  });

  @override
  State<ItineraireMapPage> createState() => _ItineraireMapPageState();
}

class _ItineraireMapPageState extends State<ItineraireMapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _userLocation;
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  List<Map<String, dynamic>> _directionsSteps = [];
  bool _mapCreated = false;

  String? _durationText;
  String? _distanceText;

  Set<Circle> _circles = {};
  LatLng? _currentPosition;
  BitmapDescriptor? _customMarkerIcon;

  @override
  void initState() {
    super.initState();
    _initPosition();
  }

  Future<void> _initPosition() async {
    final position = await LocationService.getCurrentPosition();
    _currentPosition = LatLng(position!.latitude, position!.longitude);
    setState(() => _userLocation = _currentPosition);

    _loadMapElements(_currentPosition!);
  }

  Future<void> _loadMapElements(LatLng userLatLng) async {
    final prLatLng =
        LatLng(widget.pointRelais.latitude!, widget.pointRelais.longitude!);

    _markers.addAll([
      Marker(
        markerId: const MarkerId('user'),
        position: userLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(title: "Vous"),
      ),
      Marker(
        markerId: const MarkerId('pr'),
        position: prLatLng,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: "Point Relais"),
      ),
    ]);

    await _getDirections(userLatLng, prLatLng);
  }

  String _cleanHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&');
  }

  Future<void> _getDirections(LatLng origin, LatLng destination) async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
        '&mode=driving'
        '&key=${LocationService.APIKEY}',
      );

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception("Google Directions API error: ${response.statusCode}");
      }

      final data = json.decode(response.body);

      if (data['status'] == 'ZERO_RESULTS') {
        setState(() {
          _durationText = null;
          _distanceText = null;
          _directionsSteps = [];
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  "Aucun itinéraire trouvé entre vous et ce point relais")),
        );
        return;
      }

      if (data['status'] != 'OK') {
        throw Exception("Directions status: ${data['status']}");
      }

      final route = data['routes'][0];
      final leg = route['legs'][0];

      final polylineEncoded = route['overview_polyline']['points'];
      final polylineCoords = _decodePolyline(polylineEncoded);

      final steps = leg['steps'] as List<dynamic>;
      final parsedSteps = steps.map((step) {
        return {
          'instruction': _cleanHtml(step['html_instructions']),
          'distance': step['distance']['text'],
        };
      }).toList();

      setState(() {
        _durationText = leg['duration']['text'];
        _distanceText = leg['distance']['text'];
        _directionsSteps = parsedSteps;

        _polylines = {
          Polyline(
            polylineId: const PolylineId('route'),
            color: Colors.blue,
            width: 5,
            points: polylineCoords,
          ),
        };
      });

      // Fit bounds on route
      final controller = await _controller.future;
      final bounds = LatLngBounds(
        southwest: LatLng(
          origin.latitude < destination.latitude
              ? origin.latitude
              : destination.latitude,
          origin.longitude < destination.longitude
              ? origin.longitude
              : destination.longitude,
        ),
        northeast: LatLng(
          origin.latitude > destination.latitude
              ? origin.latitude
              : destination.latitude,
          origin.longitude > destination.longitude
              ? origin.longitude
              : destination.longitude,
        ),
      );

      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
    } catch (e) {
      print("❌ Erreur dans _getDirections: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Erreur lors de la récupération de l’itinéraire")),
      );
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
      int dlat = (result & 1) != 0 ? ~(result >> 1) : result >> 1;
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : result >> 1;
      lng += dlng;

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }

    return points;
  }

  Future<void> _fitBounds() async {
    final controller = await _controller.future;
    final positions = [widget.pointRelais]
        .map((e) => LatLng(e.latitude!, e.longitude!))
        .toList();
    positions.add(_currentPosition!);
    final bounds = boundsFromLatLngList(positions);

    CameraUpdate update = CameraUpdate.newLatLngBounds(bounds, 60);
    controller.animateCamera(update);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.pointRelais.libelle}",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: MyColors.secondary, fontWeight: FontWeight.bold),
            ),
            Text(
              "${_durationText ?? ""} • ${_distanceText ?? ""}",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: MyColors.secondary, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: _userLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _userLocation!, zoom: 15),
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
                ),
                if (_durationText != null && _distanceText != null)
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.directions_walk,
                                  color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(_distanceText!,
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.access_time, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(_durationText!,
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                if (_directionsSteps.isNotEmpty)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, -2),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text("🗺️ Itinéraire détaillé",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _directionsSteps.length,
                              itemBuilder: (context, index) {
                                final step = _directionsSteps[index];
                                return ListTile(
                                  leading: const Icon(Icons.directions,
                                      color: Colors.blue),
                                  title: Text(step['instruction']!),
                                  trailing: Text(step['distance']!),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
    );
  }
}
