import 'package:get/get.dart';
import 'package:lpr/controllers/GeneralController.dart';
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
    GeneralController controller = Get.find();
    controller.deconnexion();
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
      controller.connected.value = true;
      controller.client.value = client;
      return client;
    } else {
      print("🚫 Aucun client en local");
      controller.connected.value = false;
      return null;
    }
  }
}
