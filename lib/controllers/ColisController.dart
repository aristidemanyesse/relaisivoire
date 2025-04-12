import 'package:get/get.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/models/ColisApp/StatusColis.dart';
import 'package:lpr/services/StoreService.dart';

class ColisController extends GetxController {
  Rx<List<Colis>> liste_attentes = Rx<List<Colis>>([]);
  Rx<List<Colis>> liste_en_cours = Rx<List<Colis>>([]);

  @override
  void onInit() async {
    await Future.delayed(Duration(seconds: 1));
    final store = await getStore();
    final box = store.box<Colis>();
    final listecolis = box.getAll();

    liste_attentes.value = listecolis
        .where((colis) => colis.status.target!.level == StatusColis.EN_ATTENTE)
        .toList();

    liste_en_cours.value = listecolis
        .where((colis) => colis.status.target!.level != StatusColis.EN_ATTENTE)
        .toList();

    super.onInit();
  }
}
