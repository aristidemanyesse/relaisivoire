import 'package:objectbox/objectbox.dart';

@Entity()
class TypePointRelais {
  int id = 0;

  @Index()
  String uid;

  String libelle;

  TypePointRelais({
    this.uid = "",
    required this.libelle,
  });

  factory TypePointRelais.fromJson(Map<String, dynamic> json) {
    return TypePointRelais(
      uid: json['id'],
      libelle: json['libelle'],
    );
  }

  Map<String, dynamic> toJson() => {
        'libelle': libelle,
      };
}
