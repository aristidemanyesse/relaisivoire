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
  void onInit() {
    confirmCGU.value = false;
    utilisateur.value = null;
    client.value = null;

    ever(client, (value) async {
      if (value == null) return;
      await CustomUser.connexion(value.contact);
      final store = await getStore();
      final sync = SyncService(store: store);
      sync.putIfNotNull(store.box<Client>(), value);
      await sync.syncAllData();
    });

    super.onInit();
  }
}
