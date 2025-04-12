import 'package:objectbox/objectbox.dart';

@Entity()
class TypeDestinataire {
  int id = 0;

  @Index()
  String uid;

  String libelle;
  String? description;
  int? level;

  TypeDestinataire({
    this.uid = "",
    this.description = "",
    required this.libelle,
    this.level = 0,
  });

  factory TypeDestinataire.fromJson(Map<String, dynamic> json) {
    return TypeDestinataire(
      uid: json['id'],
      libelle: json['libelle'],
      description: json['description'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() => {
        'libelle': libelle,
        'description': description,
        'level': level,
      };
}
