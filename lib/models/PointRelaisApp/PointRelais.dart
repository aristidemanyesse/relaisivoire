import 'package:lpr/models/PointRelaisApp/TypePointRelais.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class PointRelais {
  int id = 0;

  String libelle;
  String address;
  double latitude;
  double longitude;

  final type = ToOne<TypePointRelais>(); // 🔁 Relation vers TypePointRelais

  PointRelais({
    this.id = 0,
    required this.libelle,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory PointRelais.fromJson(Map<String, dynamic> json) {
    final point = PointRelais(
      id: json['id'] ?? 0,
      libelle: json['libelle'],
      address: json['address'],
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );

    if (json['type'] != null) {
      point.type.target = TypePointRelais.fromJson(json['type']);
    }

    return point;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'libelle': libelle,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'type': type.target?.toJson(),
      };

  String shortLabel() => "$libelle - ${type.target?.libelle ?? "Type ?"}";
}
