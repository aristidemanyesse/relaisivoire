import 'package:objectbox/objectbox.dart';

@Entity()
class StatusColis {
  static const ANNULE = 1;
  static const EN_ATTENTE = 2;
  static const DEPOSE = 3;
  static const ASSIGNATION = 4;
  static const LIVRAISON = 5;
  static const RETRAIT = 6;

  int id = 0;

  @Index()
  String uid;

  String libelle;
  String description = "";
  String color = "";
  int level;

  StatusColis({
    this.uid = "",
    required this.libelle,
    required this.level,
    this.description = "",
    this.color = "",
  });

  factory StatusColis.fromJson(Map<String, dynamic> json) {
    return StatusColis(
      uid: json['id'],
      libelle: json['libelle'],
      level: json['level'],
      description: json['description'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() => {
        'libelle': libelle,
        'level': level,
        'description': description,
        'color': color,
      };
}
