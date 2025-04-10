import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lpr/models/ClientApp/Client.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/services/SyncService.dart';

class SessionService {
  final SyncService syncService;

  SessionService({required this.syncService});

  // 🔍 Vérifie s'il y a un client actif en local
  Client? getActiveClient() {
    final box = syncService.store.box<Client>();
    final clients = box.getAll();

    if (clients.isNotEmpty) {
      print("🔐 Client trouvé en local : ${clients.first.contact}");
      return clients.first;
    }

    print("🚫 Aucun client en local");
    return null;
  }

  // 🧼 Nettoie le cache (ex : à la déconnexion)
  void clearClientSession() {
    syncService.store.box<Client>().removeAll();
    syncService.store.box<Colis>().removeAll();
    print("🧹 Session client & colis nettoyée.");
  }

  // 🔁 À lancer au démarrage de l'app
  Future<Client?> restoreOrAuthenticate() async {
    final client = getActiveClient();

    if (client != null) {
      final connected = await isConnected();

      if (connected) {
        // 🔄 Synchroniser les colis du client
        // await syncService.syncColisClient(client.id);
      }

      return client;
    }

    return null;
  }

  // ✅ Vérifie s'il y a du réseau
  Future<bool> isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
