import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:lpr/models/ClientApp/Client.dart';
import 'package:lpr/models/AdministrationApp/CustomUser.dart';
import 'package:lpr/services/StoreService.dart';
import 'package:lpr/services/SyncService.dart';

class GeneralController extends GetxController {
  RxBool connected = false.obs;
  RxBool confirmCGU = false.obs;
  RxString token = "".obs;
  RxString refreshToken = "".obs;
  Rx<CustomUser?> utilisateur = Rx<CustomUser?>(null);
  Rx<Client?> client = Rx<Client?>(null);

  @override
  void onInit() async {
    super.onInit();

    ever(client, (value) async {
      if (value != null) {
        final store = await getStore();
        SyncService syncService = SyncService(store: store);
        await CustomUser.connexion(value.contact);
        SyncService.putIfNotNull(syncService.store.box<Client>(), value);
        final connected = await isConnected();
        if (connected) {
          // 🔄 Synchroniser les colis du client
          await syncService.syncAllData();
        }
      }
    });
  }

  void deconnexion() {
    connected.value = false;
    confirmCGU.value = false;
    utilisateur.value = null;
    client.value = null;
    token.value = "";
    refreshToken.value = "";
    onInit();
  }

  // ✅ Vérifie s'il y a du réseau
  Future<bool> isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
