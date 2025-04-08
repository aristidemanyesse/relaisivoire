import 'package:get/get.dart';
import 'package:lpr/components/tools/apiservice.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/models/ClientApp/CustomUser.dart';
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

  static Future<Client?> searchByContact(String contact) async {
    Map<String, dynamic> response =
        await ApiService.get('api/clients/search-by-contact/?contact=$contact');
    if (response["status"] && response["data"].length > 0) {
      return Client.fromJson(response["data"][0]);
    } else {
      return null;
    }
  }

  void connexion() async {
    Map<String, dynamic> datas = await ApiService.post(
        'api/auth/login/', {'username': contact, 'password': contact});
    if (datas.containsKey('access')) {
      GeneralController controller = Get.find();
      controller.token.value = datas['access'];
      controller.refreshToken.value = datas['refresh'];
    }
  }

  // ✅ Méthode d'instance : mini résumé
  void inscription() async {
    GeneralController controller = Get.find();
    Map<String, dynamic> response =
        await ApiService.post('api/clients/', {'user': 1, 'contact': contact});
    if (response["status"]) {
      Client client = Client.fromJson(response["data"]);
      client.genereOtp();
    }
  }

  // ✅ Méthode d'instance : mini résumé
  void genereOtp() async {
    Map<String, dynamic> response =
        await ApiService.post('api/clients/genere-otp/', {"id": uid});
  }

  // ✅ Méthode d'instance : mini résumé
  Future<bool> verifyOtp(String otp) async {
    Map<String, dynamic> response = await ApiService.post(
        'api/clients/verify-otp/', {"id": uid, "otp": otp});
    if (response['status'] && response['data'] != null) {
      connexion();
      return true;
    }
    return false;
  }

  // ✅ Méthode d'instance : affichage complet
  // String fullName() => "$prenoms $nom";

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
