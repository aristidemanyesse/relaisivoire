import 'dart:async';

import 'package:get/get.dart';
import 'package:relaisivoire/controllers/GeneralController.dart';
import 'package:relaisivoire/models/ColisApp/Colis.dart';
import 'package:relaisivoire/models/ColisApp/StatusColis.dart';
import 'package:relaisivoire/objectbox.g.dart';
import 'package:relaisivoire/services/StoreService.dart';
import 'package:relaisivoire/services/SyncService.dart';

class ColisController extends GetxController {
  Rx<List<Colis>> colis = Rx<List<Colis>>([]);
  Rx<List<Colis>> listeAttentes = Rx<List<Colis>>([]);
  Rx<List<Colis>> listeEnCours = Rx<List<Colis>>([]);
  Rx<List<Colis>> historique = Rx<List<Colis>>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Timer timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      reload();
    });

    ever(colis, (value) {
      listeAttentes.value = value
          .where(
            (colis) => colis.status.target?.level == StatusColis.EN_ATTENTE,
          )
          .toList();

      listeEnCours.value = value
          .where(
            (colis) => colis.status.target?.level != StatusColis.EN_ATTENTE,
          )
          .toList();
    });
  }

  void reload() async {
    GeneralController controller = Get.find();
    if (controller.client.value == null) return;
    print("🔄 Démarrage de la synchronisation des colis...");
    Store store = await getStore();
    SyncService syncService = SyncService(store: store);
    colis.value = await syncService.syncGenericList<Colis>(
      endpoint:
          'api/colis/colis-for-client/?id=${controller.client.value!.uid}',
      fromJson: (json) => Colis.fromJson(json),
      box: store.box<Colis>(),
      label: "Colis",
    );
  }
}
