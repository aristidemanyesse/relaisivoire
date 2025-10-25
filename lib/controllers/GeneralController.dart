import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:get/get.dart';
import 'package:lpr/controllers/KeyBoardController.dart';
import 'package:lpr/models/ClientApp/Client.dart';
import 'package:lpr/models/AdministrationApp/CustomUser.dart';
import 'package:lpr/pages/Login_number.dart';
import 'package:lpr/pages/PleaseWait2.dart';
import 'package:lpr/services/LoactionService.dart';
import 'package:lpr/services/SessionService.dart';
import 'package:lpr/services/StoreService.dart';
import 'package:lpr/services/SyncService.dart';

class GeneralController extends GetxController {
  RxBool connected = false.obs;
  RxBool confirmCGU = false.obs;
  RxString fcmToken = "".obs;
  RxString token = "".obs;
  RxString refreshToken = "".obs;
  Rx<CustomUser?> utilisateur = Rx<CustomUser?>(null);
  Rx<Client?> client = Rx<Client?>(null);
  Rx<Position?> position = Rx<Position?>(null);

  @override
  void onReady() async {
    super.onReady();
    getFCMToken();
    position.value = await LocationService.getCurrentPosition();
  }

  @override
  void onInit() async {
    super.onInit();

    ever(client, (value) async {
      if (value != null) {
        final store = await getStore();
        SyncService syncService = SyncService(store: store);
        bool test = await CustomUser.connexion(value.contact);
        if (!test) {
          print("🚫 Erreur lors du changement de client");
          deconnexion();
        }
        SyncService.putIfNotNull(syncService.store.box<Client>(), value);
        final connected = await GeneralController.isConnected();
        if (connected) {
          // 🔄 Synchroniser les colis du client
          await syncService.syncAllData();
        }
      }
    });
  }

  void getFCMToken() async {
    FirebaseMessaging.instance.getAPNSToken().then((apnsToken) {
      print("APNs Token: $apnsToken");
      // fcmToken.value = apnsToken ?? "";
    });
    fcmToken.value = await FirebaseMessaging.instance.getToken() ?? "";
    print("🔑 Token FCM: $fcmToken");
  }

  void deconnexion() async {
    Get.to(PleaseWait2());
    connected.value = false;
    confirmCGU.value = false;
    utilisateur.value = null;
    client.value = null;
    token.value = "";
    refreshToken.value = "";
    client.value?.user.target!.update({'fcmtoken': ""});
    onInit();

    final store = await getStore();
    final sync = SyncService(store: store);
    final session = SessionService(syncService: sync);
    session.clearClientSession();
    KeyBoardController keyBoardController = Get.find();
    keyBoardController.onInit();
    Get.offAll(LoginNumber());
  }

  // ✅ Vérifie s'il y a du réseau
  static Future<bool> isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
