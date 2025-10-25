import 'package:objectbox/objectbox.dart';

@Entity()
class TypeService {
  int id = 0;

  @Index()
  String uid;

  String libelle;

  TypeService({
    this.uid = "",
    required this.libelle,
  });

  factory TypeService.fromJson(Map<String, dynamic> json) {
    return TypeService(
      uid: json['id'],
      libelle: json['libelle'],
    );
  }

  Map<String, dynamic> toJson() => {
        'libelle': libelle,
      };
}
