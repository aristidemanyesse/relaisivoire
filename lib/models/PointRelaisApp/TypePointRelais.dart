import 'package:objectbox/objectbox.dart';

@Entity()
class TypePointRelais {
  int id = 0;

  @Index()
  String uid;

  String libelle;
  int level;

  TypePointRelais({
    this.uid = "",
    required this.libelle,
    required this.level,
  });

  factory TypePointRelais.fromJson(Map<String, dynamic> json) {
    return TypePointRelais(
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
