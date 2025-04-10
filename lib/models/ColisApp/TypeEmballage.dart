import 'package:objectbox/objectbox.dart';

@Entity()
class TypeEmballage {
  int id = 0;

  @Index()
  String uid;

  String libelle;
  int level;

  TypeEmballage({
    this.uid = "",
    required this.libelle,
    required this.level,
  });

  factory TypeEmballage.fromJson(Map<String, dynamic> json) {
    return TypeEmballage(
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
