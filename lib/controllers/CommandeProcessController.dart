import 'package:get/get.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/models/ColisApp/TypeColis.dart';
import 'package:lpr/models/ColisApp/TypeDestinataire.dart';
import 'package:lpr/models/ColisApp/TypeEmballage.dart';
import 'package:lpr/models/PointRelaisApp/PointRelais.dart';
import 'package:lpr/pages/ColisPage.dart';
import 'package:lpr/pages/PleaseWait.dart';

class CommandeProcessController extends GetxController {
  Rx<TypeColis?> typeColis = Rx<TypeColis?>(null);
  Rx<TypeEmballage?> typeEmballage = Rx<TypeEmballage?>(null);
  Rx<TypeDestinataire?> typeDestinataire = Rx<TypeDestinataire?>(null);
  Rx<PointRelais?> pointRelais = Rx<PointRelais?>(null);
  Rx<String> nomDestinataire = "".obs;
  Rx<String> contactDestinataire = "".obs;
  RxInt price = RxInt(0);

  @override
  void onInit() {
    typeColis.value = null;
    typeEmballage.value = null;
    typeDestinataire.value = null;
    pointRelais.value = null;
    nomDestinataire.value = "";
    contactDestinataire.value = "";
    price.value = 0;

    ever(typeColis, (_) {
      price.value = calculPrice();
    });

    ever(typeEmballage, (_) {
      price.value = calculPrice();
    });

    super.onInit();
  }

  int calculPrice() {
    int price = 0;
    if (typeColis.value != null) {
      price += typeColis.value!.price;
    }
    if (typeEmballage.value != null && typeEmballage.value!.level == 2) {
      price += typeColis.value!.emballage.target?.price ?? 0;
    }
    return price;
  }

  void create() async {
    GeneralController generalController = Get.find();
    Get.dialog(const PleaseWait());
    try {
      Colis colis = Colis();
      colis.sender.target = generalController.client.value;
      colis.pointRelaisReceiver.target = pointRelais.value;
      colis.typeColis.target = typeColis.value;
      colis.typeEmballage.target = typeEmballage.value;
      colis.typeDestinataire.target = typeDestinataire.value;
      colis.receiverName = nomDestinataire.value;
      colis.receiverPhone = contactDestinataire.value;
      Colis colis_ = await colis.save();
      onInit();
      await Future.delayed(const Duration(seconds: 5), () {
        Get.offAll(ColisPage(colis: colis_, sent: false));
      });
    } catch (e) {
      Get.back();
      Get.snackbar(
          "Ooups !!!", "Une erreur est survenue, veuillez recommencer.");
    }
  }
}
