import 'package:objectbox/objectbox.dart';

@Entity()
class Commune {
  int id = 0;

  @Index()
  String uid;

  String libelle;

  Commune({
    this.uid = "",
    required this.libelle,
  });

  factory Commune.fromJson(Map<String, dynamic> json) {
    return Commune(
      uid: json['id'],
      libelle: json['libelle'],
    );
  }

  Map<String, dynamic> toJson() => {
        'libelle': libelle,
      };
}
