import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lpr/components/tools/apiservice.dart';
import 'dart:convert';

import 'package:lpr/models/ClientApp/Client.dart';
import 'package:lpr/models/ClientApp/TypeClient.dart';
import 'package:objectbox/objectbox.dart';

class ClientController extends GetxController {
  RxBool confirmCGU = false.obs;

  @override
  void onInit() {
    confirmCGU.value = false;
    super.onInit();
  }

  Future<void> connexion(String contact) async {
    dynamic datas = ApiService.request(
        'api/auth/login/', {'username': contact, 'password': contact});
    print(datas);

    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);

    //   final typeClient = TypeClient.fromJson(data['type_client']);
    //   final typeBox = store.box<TypeClient>();
    //   typeBox.put(typeClient);

    //   final client = Client.fromJson(data);

    //   final clientBox = store.box<Client>();
    //   clientBox.put(client);

    //   print(
    //       "📦 Client ${client.nom} & TypeClient ${typeClient.libelle} enregistrés !");
    // } else {
    //   print("❌ Erreur API: ${response.statusCode}");
    // }
  }

  // Future<void> get(int id, Store store) async {
  //   final url = Uri.parse('https://ton-backend.com/api/clients/$id/');
  //   final response = await http.get(url, headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     // 'Authorization': 'Bearer YOUR_TOKEN' // si besoin
  //   });

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);

  //     final typeClient = TypeClient.fromJson(data['type_client']);
  //     final typeBox = store.box<TypeClient>();
  //     typeBox.put(typeClient);

  //     final client = Client.fromJson(data);

  //     final clientBox = store.box<Client>();
  //     clientBox.put(client);

  //     print(
  //         "📦 Client ${client.nom} & TypeClient ${typeClient.libelle} enregistrés !");
  //   } else {
  //     print("❌ Erreur API: ${response.statusCode}");
  //   }
  // }
}
