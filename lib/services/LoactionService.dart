import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position?> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 🔍 Vérifie si le service GPS est activé
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("❌ GPS désactivé !");
      return null;
    }

    // 🔐 Vérifie les permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("❌ Permission refusée !");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("❌ Permission refusée définitivement !");
      return null;
    }

    // ✅ Tout est bon, récupère la position
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    return Geolocator.getCurrentPosition(locationSettings: locationSettings);
  }
}
