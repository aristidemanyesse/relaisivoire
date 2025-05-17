import 'dart:async';

import 'package:get/get.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/models/ClientApp/NotificationClient.dart';
import 'package:lpr/objectbox.g.dart';
import 'package:lpr/services/StoreService.dart';
import 'package:lpr/services/SyncService.dart';

class NotificationController extends GetxController {
  Rx<List<NotificationClient>> notifications = Rx<List<NotificationClient>>([]);
  Rx<List<NotificationClient>> notReads = Rx<List<NotificationClient>>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Timer timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      reload();
    });

    ever(notifications, (value) {
      notReads.value = value.where((item) => !item.read).toList();
    });
  }

  void reload() async {
    GeneralController controller = Get.find();
    if (controller.client.value == null) return;
    print("🔄 Démarrage de la synchronisation des notifications...");
    Store store = await getStore();
    SyncService syncService = SyncService(store: store);
    notifications.value = await syncService.syncGenericList<NotificationClient>(
        endpoint:
            'api/notifications/search/?id=${controller.client.value!.uid}',
        fromJson: (json) => NotificationClient.fromJson(json),
        box: store.box<NotificationClient>(),
        label: "Colis");
  }
}
