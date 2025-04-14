import 'package:lpr/models/ClientApp/Client.dart';
import 'package:lpr/models/ColisApp/StatusColis.dart';
import 'package:lpr/models/ColisApp/TypeColis.dart';
import 'package:lpr/models/ColisApp/TypeDestinataire.dart';
import 'package:lpr/models/ColisApp/TypeEmballage.dart';
import 'package:lpr/models/PointRelaisApp/PointRelais.dart';
import 'package:lpr/services/ApiService.dart';
import 'package:lpr/services/StoreService.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Colis {
  int id = 0;

  @Index()
  String uid;

  String code;
  String receiver_name;
  String receiver_phone;
  int total;
  final sender = ToOne<Client>();
  final receiver = ToOne<Client>();
  final pointRelaisSender = ToOne<PointRelais>();
  final pointRelaisReceiver = ToOne<PointRelais>();
  final typeColis = ToOne<TypeColis>();
  final typeEmballage = ToOne<TypeEmballage>();
  final typeDestinataire = ToOne<TypeDestinataire>();
  final status = ToOne<StatusColis>();
  DateTime? date_creation;

  DateTime? depotDate;
  DateTime? recuperationDate;
  DateTime? livraisonDate;
  DateTime? retraitDate;

  Colis(
      {this.id = 0,
      this.uid = "",
      this.code = "",
      this.receiver_name = "",
      this.receiver_phone = "",
      this.total = 0,
      this.depotDate,
      this.recuperationDate,
      this.livraisonDate,
      this.retraitDate,
      this.date_creation});

  /// Parser depuis JSON API
  factory Colis.fromJson(Map<String, dynamic> json) {
    final colis = Colis(
      uid: json['id'],
      code: json['code'],
      receiver_name: json['receiver_name'],
      receiver_phone: json['receiver_phone'],
      total: json['total'] ?? 0,
      date_creation: DateTime.tryParse(json['date_creation'] ?? ""),
      depotDate: DateTime.tryParse(json['depot_date'] ?? ""),
      recuperationDate: DateTime.tryParse(json['recuperation_date'] ?? ""),
      livraisonDate: DateTime.tryParse(json['livraison_date'] ?? ""),
      retraitDate: DateTime.tryParse(json['retrait_date'] ?? ""),
    );

    if (json['sender'] != null) {
      colis.sender.target = Client.fromJson(json['sender']);
    }
    if (json['receiver'] != null) {
      colis.receiver.target = Client.fromJson(json['receiver']);
    }
    if (json['point_relais_sender'] != null) {
      colis.pointRelaisSender.target =
          PointRelais.fromJson(json['point_relais_sender']);
    }
    if (json['point_relais_receiver'] != null) {
      colis.pointRelaisReceiver.target =
          PointRelais.fromJson(json['point_relais_receiver']);
    }
    if (json['type_colis'] != null) {
      colis.typeColis.target = TypeColis.fromJson(json['type_colis']);
    }
    if (json['type_emballage'] != null) {
      colis.typeEmballage.target =
          TypeEmballage.fromJson(json['type_emballage']);
    }
    if (json['type_destinataire'] != null) {
      colis.typeDestinataire.target =
          TypeDestinataire.fromJson(json['type_destinataire']);
    }
    if (json['status'] != null) {
      colis.status.target = StatusColis.fromJson(json['status']);
    }

    return colis;
  }

  /// Convertir vers JSON
  Map<String, dynamic> toJson() => {
        'code': code,
        'receiver_name': receiver_name,
        'receiver_phone': receiver_phone,
        'sender': sender.target?.uid ?? "",
        'receiver': receiver.target?.uid ?? "",
        'total': total,
        'point_relais_sender': pointRelaisSender.target?.uid,
        'point_relais_receiver': pointRelaisReceiver.target?.uid,
        'type_colis': typeColis.target?.uid,
        'type_emballage': typeEmballage.target?.uid,
        'type_destinataire': typeDestinataire.target?.uid
      };

  Future<Colis> save() async {
    final data = await ApiService.post('api/colis/', toJson());
    final datas = await ApiService.get("api/colis/${data['data']["id"]}/");
    final colis = Colis.fromJson(datas['data']);

    final store = await getStore();
    final colisBox = store.box<Colis>();
    colisBox.put(colis);
    return colis;
  }

  String title() => typeColis.target?.libelle ?? "type colis";

  String getCode() =>
      "LPR - ${code.substring(0, 3)} ${code.substring(3, 6)} ${code.substring(6, 9)}";
}
