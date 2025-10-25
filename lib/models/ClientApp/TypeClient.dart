import 'package:objectbox/objectbox.dart';

@Entity()
class TypeClient {
  int id = 0;

  @Index()
  String uid;

  String libelle;
  int level;

  TypeClient({
    this.uid = "",
    required this.libelle,
    required this.level,
  });

  factory TypeClient.fromJson(Map<String, dynamic> json) {
    return TypeClient(
      uid: json['id'],
      libelle: json['libelle'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() => {
        'libelle': libelle,
        'level': level,
      };
}
