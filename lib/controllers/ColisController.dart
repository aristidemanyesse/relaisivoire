import 'dart:async';

import 'package:get/get.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/models/ColisApp/StatusColis.dart';
import 'package:lpr/models/ColisApp/TypeColis.dart';
import 'package:lpr/models/ColisApp/TypeDestinataire.dart';
import 'package:lpr/models/ColisApp/TypeEmballage.dart';
import 'package:lpr/models/PointRelaisApp/PointRelais.dart';
import 'package:lpr/models/ZoneApp/Commune.dart';
import 'package:lpr/objectbox.g.dart';
import 'package:lpr/services/StoreService.dart';
import 'package:lpr/services/SyncService.dart';

class ColisController extends GetxController {
  Rx<List<Colis>> colis = Rx<List<Colis>>([]);
  Rx<List<Colis>> listeAttentes = Rx<List<Colis>>([]);
  Rx<List<Colis>> listeEnCours = Rx<List<Colis>>([]);
  Rx<List<Colis>> historique = Rx<List<Colis>>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Timer _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      reload();
    });

    ever(colis, (value) {
      listeAttentes.value = value
          .where(
              (colis) => colis.status.target!.level == StatusColis.EN_ATTENTE)
          .toList();

      listeEnCours.value = value
          .where(
              (colis) => colis.status.target!.level != StatusColis.EN_ATTENTE)
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
        label: "Colis");
  }
}
