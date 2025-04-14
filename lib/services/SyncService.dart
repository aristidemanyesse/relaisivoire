import 'package:get/get.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/controllers/HandleTypesController.dart';
import 'package:lpr/models/ClientApp/TypeClient.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/models/ColisApp/StatusColis.dart';
import 'package:lpr/models/ColisApp/TypeColis.dart';
import 'package:lpr/models/ColisApp/TypeDestinataire.dart';
import 'package:lpr/models/ColisApp/TypeEmballage.dart';
import 'package:lpr/models/PointRelaisApp/PointRelais.dart';
import 'package:lpr/models/PointRelaisApp/TypePointRelais.dart';
import 'package:lpr/models/PointRelaisApp/TypeService.dart';
import 'package:lpr/models/ZoneApp/Commune.dart';
import 'package:lpr/objectbox.g.dart';
import 'package:lpr/services/ApiService.dart';

class SyncService {
  final Store store;

  SyncService({required this.store});

  static void putIfNotNull<T>(Box<T> box, T? obj) {
    if (obj != null) {
      box.put(obj);
    }
  }

  Future<List<T>> _syncGenericList<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    required Box<T> box,
    String? label,
  }) async {
    try {
      final datas = await ApiService.getAll(endpoint);
      final entities = datas.map((e) => fromJson(e)).toList();
      box.removeAll();
      box.putMany(entities);
      print("✔️ ${label ?? T.toString()}: ${entities.length} items sync");
      return entities;
    } catch (e) {
      print("⚠️ Exception lors de $endpoint : $e");
      return [];
    }
  }

  Future<void> syncAllData() async {
    print("🔄 Démarrage de la synchronisation des types...");
    GeneralController controller = Get.find();
    HandleTypesController handleTypesController = Get.find();

    handleTypesController.listeTypeColis.value =
        await _syncGenericList<TypeColis>(
            endpoint: 'api/type_colis/',
            fromJson: (json) => TypeColis.fromJson(json),
            box: store.box<TypeColis>(),
            label: "TypeColis");

    handleTypesController.listeTypeEmballages.value =
        await _syncGenericList<TypeEmballage>(
            endpoint: 'api/type_emballage/',
            fromJson: (json) => TypeEmballage.fromJson(json),
            box: store.box<TypeEmballage>(),
            label: "TypeEmballage");

    handleTypesController.listeTypeDestinataires.value =
        await _syncGenericList<TypeDestinataire>(
            endpoint: 'api/type_destinataire/',
            fromJson: (json) => TypeDestinataire.fromJson(json),
            box: store.box<TypeDestinataire>(),
            label: "TypeDestinataire");

    await _syncGenericList<StatusColis>(
        endpoint: 'api/status_colis/',
        fromJson: (json) => StatusColis.fromJson(json),
        box: store.box<StatusColis>(),
        label: "StatusColis");

    await _syncGenericList<TypeClient>(
        endpoint: 'api/type_clients/',
        fromJson: (json) => TypeClient.fromJson(json),
        box: store.box<TypeClient>(),
        label: "TypeClient");

    await _syncGenericList<TypePointRelais>(
        endpoint: 'api/type_points_relais/',
        fromJson: (json) => TypePointRelais.fromJson(json),
        box: store.box<TypePointRelais>(),
        label: "TypePointRelais");

    await _syncGenericList<Commune>(
        endpoint: 'api/communes/',
        fromJson: (json) => Commune.fromJson(json),
        box: store.box<Commune>(),
        label: "Commune");

    await _syncGenericList<TypeService>(
        endpoint: 'api/type_services/',
        fromJson: (json) => TypeService.fromJson(json),
        box: store.box<TypeService>(),
        label: "TypeService");

    await _syncGenericList<Colis>(
        endpoint:
            'api/colis/colis-for-client/?id=${controller.client.value!.uid}',
        fromJson: (json) => Colis.fromJson(json),
        box: store.box<Colis>(),
        label: "Colis");

    handleTypesController.historique.value = await _syncGenericList<Colis>(
        endpoint:
            'api/colis/historique-client/?id=${controller.client.value!.uid}',
        fromJson: (json) => Colis.fromJson(json),
        box: store.box<Colis>(),
        label: "Colis");

    handleTypesController.listePointsRelais.value =
        await _syncGenericList<PointRelais>(
            endpoint: 'api/points_relais/',
            fromJson: (json) => PointRelais.fromJson(json),
            box: store.box<PointRelais>(),
            label: "PointRelais");

    print("✅ Tous les types de base sont synchronisés.");
  }
}
