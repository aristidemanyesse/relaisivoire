import 'package:objectbox/objectbox.dart';

@Entity()
class TypeEmballage {
  int id = 0;

  @Index()
  String uid;

  String libelle;
  int price;
  int level;

  TypeEmballage({
    this.uid = "",
    required this.libelle,
    this.level = 0,
    this.price = 0,
  });

  factory TypeEmballage.fromJson(Map<String, dynamic> json) {
    return TypeEmballage(
      uid: json['id'],
      libelle: json['libelle'],
      level: json['level'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() => {
        'libelle': libelle,
        'level': level,
        'price': price,
      };
}
