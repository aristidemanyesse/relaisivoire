import 'package:relaisivoire/models/PointRelaisApp/Schedule.dart';
import 'package:relaisivoire/models/PointRelaisApp/TypePointRelais.dart';
import 'package:relaisivoire/models/PointRelaisApp/TypeService.dart';
import 'package:relaisivoire/models/ZoneApp/Commune.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class PointRelais {
  int id = 0;

  @Index()
  String uid = "";

  String libelle;
  String? address;
  String? description;
  double? latitude;
  double? longitude;

  final type = ToOne<TypePointRelais>(); // 🔁 Relation vers TypePointRelais
  final commune = ToOne<Commune>(); // 🔁 Relation vers TypePointRelais
  final services = ToMany<TypeService>(); // 🔁 Relation vers TypePointRelais
  final schedules = ToMany<Schedule>(); // 🔁 Relation vers TypePointRelais

  PointRelais({
    this.id = 0,
    this.uid = "",
    required this.libelle,
    this.address,
    this.description,
    this.latitude,
    this.longitude,
  });

  factory PointRelais.fromJson(Map<String, dynamic> json) {
    final point = PointRelais(
      uid: json['id'],
      libelle: json['libelle'],
      address: json['address'],
      description: json['description'],
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );

    if (json['type'] != null) {
      point.type.target = TypePointRelais.fromJson(json['type']);
    }

    if (json['commune'] != null) {
      point.commune.target = Commune.fromJson(json['commune']);
    }

    if (json['services'] != null) {
      final List services = json['services'];
      point.services.addAll(services.map((e) => TypeService.fromJson(e)));
    }

    if (json['schedules'] != null) {
      final List schedules = json['schedules'];
      point.schedules.addAll(schedules.map((e) => Schedule.fromJson(e)));
    }

    return point;
  }

  Map<String, dynamic> toJson() => {
    'libelle': libelle,
    'address': address,
    'description': description,
    'latitude': latitude,
    'longitude': longitude,
    'type': type.target?.toJson(),
    'commune': commune.target?.toJson(),
  };

  String title() => "$libelle - ${commune.target?.libelle}";

  String adresse() => "${commune.target?.libelle} - $address";
}
