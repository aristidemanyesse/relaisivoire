import 'package:get/get.dart';
import 'package:relaisivoire/models/ClientApp/NotificationClient.dart';
import 'package:relaisivoire/models/ClientApp/PalierClient.dart';
import 'package:relaisivoire/objectbox.g.dart';
import 'package:relaisivoire/services/ApiService.dart';
import 'package:relaisivoire/controllers/GeneralController.dart';
import 'package:relaisivoire/models/AdministrationApp/CustomUser.dart';
import 'package:relaisivoire/models/ClientApp/TypeClient.dart';
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
  final palier = ToOne<PalierClient>();
  final notifications = ToMany<NotificationClient>();

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
    if (json['user'] != null) {
      client.user.target = CustomUser.fromJson(json['user']);
    }
    // Liaison du type client
    if (json['type_client'] != null) {
      client.typeClient.target = TypeClient.fromJson(json['type_client']);
    }
    // Liaison du type client
    if (json['palier'] != null) {
      client.palier.target = PalierClient.fromJson(json['palier']);
    }

    if (json['notifications'] != null) {
      final List notifications = json['notifications'];
      client.notifications.addAll(
        notifications.map((e) => NotificationClient.fromJson(e)),
      );
    }

    return client;
  }

  Map<String, dynamic> toJson() => {
    'contact': contact,
    'address': address,
    'type_client': typeClient.target?.toJson(),
    'user': user.target?.toJson(),
  };

  // ✅ Méthode d'instance : mini résumé
  static Future<bool> inscription(String contact) async {
    GeneralController controller = Get.find();
    Map<String, dynamic> response = await ApiService.post('api/clients/', {
      'contact': contact,
    });
    if (response["status"] && response["data"] != null) {
      CustomUser.connexion(contact);
      return true;
    }
    return false;
  }

  static Future<Client?> searchByContact(String contact) async {
    Map<String, dynamic> response = await ApiService.get(
      'api/clients/search-by-contact/?contact=$contact',
    );
    if (response["status"] && response["data"].length > 0) {
      Client client = Client.fromJson(response["data"]);
      return client;
    } else {
      return null;
    }
  }

  void update(String nom, String prenom) async {
    user.target!.update({'first_name': nom, 'last_name': prenom});
    Client? client = await Client.searchByContact(contact);
    if (client != null) {
      GeneralController controller = Get.find();
      controller.client.value = client;
    }
  }

  Future<bool> updateContact(String number) async {
    final res = await user.target!.changeCredentials(number, number);
    if (res) {
      Map<String, dynamic> response = await ApiService.patch(
        'api/clients/$uid/',
        {'contact': number},
      );
      if (response["status"] && response["data"] != null) {
        return true;
      }
    }
    return false;
  }

  // ✅ Méthode d'instance : affichage complet
  String fullName() {
    final name = "${user.target?.firstName} ${user.target?.lastName}";
    return name == " " ? showContact() : name;
  }

  // ✅ Méthode d'instance : affichage complet
  String showContact() =>
      "${contact.substring(0, 2)} ${contact.substring(2, 5)} ${contact.substring(5, 8)} ${contact.substring(8, 10)}";
}
