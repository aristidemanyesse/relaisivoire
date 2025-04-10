import 'package:objectbox/objectbox.dart';

@Entity()
class TypeColis {
  int id = 0;

  @Index()
  String uid;

  String libelle;
  int level;

  TypeColis({
    this.uid = "",
    required this.libelle,
    required this.level,
  });

  factory TypeColis.fromJson(Map<String, dynamic> json) {
    return TypeColis(
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
