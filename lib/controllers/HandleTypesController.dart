import 'package:get/get.dart';
import 'package:relaisivoire/models/ClientApp/NotificationClient.dart';
import 'package:relaisivoire/models/ColisApp/TypeColis.dart';
import 'package:relaisivoire/models/ColisApp/TypeDestinataire.dart';
import 'package:relaisivoire/models/ColisApp/TypeEmballage.dart';
import 'package:relaisivoire/models/PointRelaisApp/PointRelais.dart';
import 'package:relaisivoire/models/ZoneApp/Commune.dart';

class HandleTypesController extends GetxController {
  Rx<List<TypeColis>> listeTypeColis = Rx<List<TypeColis>>([]);
  Rx<List<TypeEmballage>> listeTypeEmballages = Rx<List<TypeEmballage>>([]);
  Rx<List<Commune>> listeCommunes = Rx<List<Commune>>([]);
  Rx<List<TypeDestinataire>> listeTypeDestinataires =
      Rx<List<TypeDestinataire>>([]);
  Rx<List<PointRelais>> listePointsRelais = Rx<List<PointRelais>>([]);
  Rx<List<NotificationClient>> notifications = Rx<List<NotificationClient>>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
