import 'package:lpr/models/ClientApp/Client.dart';
import 'package:lpr/models/ColisApp/StatusColis.dart';
import 'package:lpr/models/ColisApp/TypeColis.dart';
import 'package:lpr/models/ColisApp/TypeDestinataire.dart';
import 'package:lpr/models/ColisApp/TypeEmballage.dart';
import 'package:lpr/models/PointRelaisApp/PointRelais.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Colis {
  int id = 0;

  String code;

  final sender = ToOne<Client>();
  final receiver = ToOne<Client>();
  final pointRelais = ToOne<PointRelais>();
  final typeColis = ToOne<TypeColis>();
  final typeEmballage = ToOne<TypeEmballage>();
  final typeDestinataire = ToOne<TypeDestinataire>();
  final status = ToOne<StatusColis>();

  DateTime? depotDate;
  DateTime? recuperationDate;
  DateTime? livraisonDate;
  DateTime? retraitDate;

  Colis({
    this.id = 0,
    required this.code,
    this.depotDate,
    this.recuperationDate,
    this.livraisonDate,
    this.retraitDate,
  });

  /// Parser depuis JSON API
  factory Colis.fromJson(Map<String, dynamic> json) {
    final colis = Colis(
      id: json['id'] ?? 0,
      code: json['code'],
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
    if (json['point_relais'] != null) {
      colis.pointRelais.target = PointRelais.fromJson(json['point_relais']);
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
        'id': id,
        'code': code,
        'sender': sender.target?.toJson(),
        'receiver': receiver.target?.toJson(),
        'point_relais': pointRelais.target?.toJson(),
        'type_colis': typeColis.target?.toJson(),
        'type_emballage': typeEmballage.target?.toJson(),
        'type_destinataire': typeDestinataire.target?.toJson(),
        'status': status.target?.toJson(),
        'depot_date': depotDate?.toIso8601String(),
        'recuperation_date': recuperationDate?.toIso8601String(),
        'livraison_date': livraisonDate?.toIso8601String(),
        'retrait_date': retraitDate?.toIso8601String(),
      };

  String statusLabel() => status.target?.libelle ?? "Inconnu";
}
