import 'package:get/get.dart';
import 'package:lpr/objectbox.g.dart';
import 'package:lpr/services/ApiService.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/models/AdministrationApp/CustomUser.dart';
import 'package:lpr/models/ClientApp/TypeClient.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Client {
  int id = 0;

  @Index()
  String uid;

  String contact;
  String? address;
  bool active;

  final typeClient = ToOne<TypeClient>();
  final user = ToOne<CustomUser>();

  Client({
    this.uid = "",
    required this.contact,
    this.address = "",
    this.active = false,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    final client = Client(
      uid: json['id'],
      contact: json['contact'],
      address: json['address'],
    );

    // // Liaison du user
    // print(json['user'].runtimeType);
    if (json['user'].runtimeType == Map) {
      client.user.target = CustomUser.fromJson(json['user']);
    }
    // Liaison du type client
    if (json['type_client'] != null) {
      client.typeClient.target = TypeClient.fromJson(json['type_client']);
    }

    return client;
  }

  Map<String, dynamic> toJson() => {
        'id': uid,
        'contact': contact,
        'address': address,
        'type_client': typeClient.target?.toJson(),
      };

  // ✅ Méthode d'instance : mini résumé
  static Future<bool> inscription(String contact) async {
    GeneralController controller = Get.find();
    Map<String, dynamic> response =
        await ApiService.post('api/clients/', {'user': 1, 'contact': contact});
    if (response["status"] && response["data"] != null) {
      CustomUser.connexion(contact);
      return true;
    }
    return false;
  }

  static Future<Client?> searchByContact(String contact) async {
    Map<String, dynamic> response =
        await ApiService.get('api/clients/search-by-contact/?contact=$contact');
    if (response["status"] && response["data"].length > 0) {
      Client client = Client.fromJson(response["data"]);
      return client;
    } else {
      return null;
    }
  }

  // ✅ Méthode d'instance : affichage complet
  String fullName() =>
      "${user.target?.firstName ?? contact} ${user.target?.lastName ?? ''}";

  // // ✅ Statique : filtrer les clients par type
  // static List<Client> filterByType(List<Client> clients, String typeName) {
  //   return clients.where((c) => c.typeClient.target?.name == typeName).toList();
  // }

  // // ✅ Statique : chercher par nom
  // static List<Client> searchByName(List<Client> clients, String query) {
  //   final lower = query.toLowerCase();
  //   return clients.where((c) {
  //     return c.nom.toLowerCase().contains(lower) ||
  //         c.prenoms.toLowerCase().contains(lower);
  //   }).toList();
  // }
}
