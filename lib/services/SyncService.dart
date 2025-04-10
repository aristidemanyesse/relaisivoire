import 'package:lpr/models/ClientApp/Client.dart';
import 'package:lpr/models/ClientApp/TypeClient.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lpr/models/ColisApp/StatusColis.dart';
import 'package:lpr/models/ColisApp/TypeColis.dart';
import 'package:lpr/models/ColisApp/TypeDestinataire.dart';
import 'package:lpr/models/ColisApp/TypeEmballage.dart';
import 'package:lpr/models/PointRelaisApp/TypePointRelais.dart';
import 'package:lpr/objectbox.g.dart';
import 'package:lpr/services/ApiService.dart';
import 'package:lpr/services/StoreService.dart';

class SyncService {
  final Store store;

  SyncService({required this.store});

  void _putIfNotNull<T>(Box<T> box, T? obj) {
    if (obj != null) {
      box.put(obj);
    }
  }

  Future<void> _syncGenericList<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    required Box<T> box,
    String? label,
  }) async {
    try {
      final response = await ApiService.get(endpoint);
      print(response);
      // if (response.statusCode == 200) {
      //   final List<dynamic> data = json.decode(response.);
      //   final entities = data.map((e) => fromJson(e)).toList();

      //   box.removeAll();
      //   box.putMany(entities);

      //   print("✔️ ${label ?? T.toString()}: ${entities.length} items sync");
      // } else {
      //   print("❌ Erreur sur $endpoint : ${response.statusCode}");
      // }
    } catch (e) {
      print("⚠️ Exception lors de $endpoint : $e");
    }
  }

  Future<void> syncAllData() async {
    print("🔄 Démarrage de la synchronisation des types...");

    await _syncGenericList<TypeColis>(
        endpoint: 'api/type_colis/',
        fromJson: (json) => TypeColis.fromJson(json),
        box: store.box<TypeColis>(),
        label: "TypeColis");

    await _syncGenericList<TypeEmballage>(
        endpoint: 'api/type_emballage/',
        fromJson: (json) => TypeEmballage.fromJson(json),
        box: store.box<TypeEmballage>(),
        label: "TypeEmballage");

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

    store.close();

    print("✅ Tous les types de base sont synchronisés.");
  }

  // 🔁 Synchronisation des colis d'un client
  // Future<void> syncColisClient(int clientId) async {
  //   final response = await http.get(
  //     Uri.parse('$baseUrl/colis/?client_id=$clientId'),
  //     headers: headers,
  //   );

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     final boxColis = store.box<Colis>();

  //     // 🧹 Supprimer les colis existants du client
  //     final old = boxColis.query(Colis_.sender.equals(clientId)).build().find();
  //     boxColis.removeMany(old.map((c) => c.id).toList());

  //     for (final jsonColis in data) {
  //       final colis = Colis.fromJson(jsonColis);
  //       boxColis.put(colis);
  //     }

  //     print("📦 ${data.length} colis rechargés pour client #$clientId");
  //   } else {
  //     print(
  //         "⚠️ Erreur lors de la récupération des colis : ${response.statusCode}");
  //   }
  // }
}
