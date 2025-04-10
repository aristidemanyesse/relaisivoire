import 'package:objectbox/objectbox.dart';

@Entity()
class StatusColis {
  int id = 0;

  @Index()
  String uid;

  String libelle;
  int level;

  StatusColis({
    this.uid = "",
    required this.libelle,
    required this.level,
  });

  factory StatusColis.fromJson(Map<String, dynamic> json) {
    return StatusColis(
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
