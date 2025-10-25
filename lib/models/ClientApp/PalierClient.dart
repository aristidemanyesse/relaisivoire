import 'package:objectbox/objectbox.dart';

@Entity()
class PalierClient {
  int id = 0;

  @Index()
  String uid;

  String libelle;
  String description;
  int level;

  PalierClient({
    this.uid = "",
    this.libelle = "",
    this.description = "",
    this.level = 0,
  });

  factory PalierClient.fromJson(Map<String, dynamic> json) {
    return PalierClient(
      uid: json['id'],
      libelle: json['libelle'],
      description: json['description'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() => {
        'libelle': libelle,
        'level': level,
        'description': description,
      };
}
