import 'package:objectbox/objectbox.dart';

@Entity()
class TypeDestinataire {
  int id = 0;

  @Index()
  String uid;

  String libelle;
  int level;

  TypeDestinataire({
    this.uid = "",
    required this.libelle,
    required this.level,
  });

  factory TypeDestinataire.fromJson(Map<String, dynamic> json) {
    return TypeDestinataire(
      uid: json['id'],
      libelle: json['libelle'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': uid,
        'libelle': libelle,
        'level': level,
      };
}
