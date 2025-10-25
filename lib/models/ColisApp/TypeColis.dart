import 'package:relaisivoire/models/ColisApp/TypeEmballage.dart';
import 'package:relaisivoire/models/LivraisonApp/TypeVehicule.dart';
import 'package:objectbox/objectbox.dart';
import 'dart:convert' show utf8;

@Entity()
class TypeColis {
  int id = 0;

  @Index()
  String uid;

  String libelle;
  int level;
  String icone;
  String description;
  double poids_min;
  double poids_max;
  int price;

  final emballage = ToOne<TypeEmballage>();
  final vehicule = ToOne<TypeVehicule>();

  TypeColis({
    this.uid = "",
    required this.libelle,
    required this.level,
    this.description = "",
    this.icone = "",
    this.poids_min = 0,
    this.poids_max = 0,
    this.price = 0,
  });

  factory TypeColis.fromJson(Map<String, dynamic> json) {
    final type = TypeColis(
      uid: json['id'],
      libelle: json['libelle'],
      level: json['level'],
      icone: json['icone'],
      description: json['description'],
      poids_min: double.parse(json['poids_min'] ?? 0),
      poids_max: double.parse(json['poids_max'] ?? 0),
      price: json['price'],
    );

    if (json['emballage'] != null) {
      type.emballage.target = TypeEmballage.fromJson(json['emballage']);
    }

    if (json['vehicule'] != null) {
      type.vehicule.target = TypeVehicule.fromJson(json['vehicule']);
    }
    return type;
  }

  Map<String, dynamic> toJson() => {
    'libelle': libelle,
    'level': level,
    'icone': icone,
    'description': description,
    'poids_min': poids_min,
    'poids_max': poids_max,
    'price': price,
    'emballage': emballage.target?.toJson(),
    'vehicule': vehicule.target?.toJson(),
  };
}
