import 'package:objectbox/objectbox.dart';
import 'dart:convert' show utf8;

@Entity()
class TypeVehicule {
  int id = 0;

  @Index()
  String uid;

  String libelle;
  String icone;
  int level;

  TypeVehicule({
    this.uid = "",
    required this.libelle,
    required this.icone,
    required this.level,
  });

  factory TypeVehicule.fromJson(Map<String, dynamic> json) {
    return TypeVehicule(
      uid: json['id'],
      libelle: json['libelle'],
      icone: json['icone'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() => {
        'libelle': libelle,
        'icone': icone,
        'level': level,
      };
}
