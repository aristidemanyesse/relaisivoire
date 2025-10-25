import 'package:get/get.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/models/AdministrationApp/CustomUser.dart';
import 'package:lpr/models/ClientApp/Client.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/services/SyncService.dart';

class SessionService {
  final SyncService syncService;

  SessionService({required this.syncService});

  // 🧼 Nettoie le cache (ex : à la déconnexion)
  void clearClientSession() {
    syncService.store.box<Client>().removeAll();
    syncService.store.box<Colis>().removeAll();
    print("🧹 Session client & colis nettoyée.");
  }

  // 🔁 À lancer au démarrage de l'app
  Future<Client?> restoreOrAuthenticate() async {
    final box = syncService.store.box<Client>();
    final clients = box.getAll();

    GeneralController controller = Get.find();
    if (clients.isNotEmpty) {
      Client client = clients.first;
      print("🔐 Client trouvé en local : ${client.contact}");

      final connected = await GeneralController.isConnected();
      if (connected) {
        bool test = await CustomUser.connexion(client.contact);
        if (!test) {
          print("🚫 Client non authentifié : ${client.contact}");
          controller.connected.value = false;
          return null;
        }
        Client? client_ = await Client.searchByContact(client.contact);
        client = client_ ?? client;
      }

      controller.client.value = client;
      controller.connected.value = true;
      return client;
    } else {
      print("🚫 Aucun client en local");
      controller.connected.value = false;
      return null;
    }
  }
}
