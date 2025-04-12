import 'package:get/get.dart';
import 'package:lpr/models/ColisApp/TypeColis.dart';
import 'package:lpr/models/ColisApp/TypeDestinataire.dart';
import 'package:lpr/models/ColisApp/TypeEmballage.dart';
import 'package:lpr/models/PointRelaisApp/PointRelais.dart';
import 'package:lpr/models/ZoneApp/Commune.dart';

class HandleTypesController extends GetxController {
  Rx<List<TypeColis>> listeTypeColis = Rx<List<TypeColis>>([]);
  Rx<List<TypeEmballage>> listeTypeEmballages = Rx<List<TypeEmballage>>([]);
  Rx<List<Commune>> listeCommunes = Rx<List<Commune>>([]);
  Rx<List<TypeDestinataire>> listeTypeDestinataires =
      Rx<List<TypeDestinataire>>([]);
  Rx<List<PointRelais>> listePointsRelais = Rx<List<PointRelais>>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
