import 'package:flutter/material.dart';
import 'package:relaisivoire/models/PointRelaisApp/PointRelais.dart';
import 'package:objectbox/objectbox.dart';

TimeOfDay parseTimeOfDay(String timeString) {
  if (timeString == "") return TimeOfDay(hour: 0, minute: 0);
  final parts = timeString.split(":");
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

@Entity()
class Schedule {
  int id = 0;

  @Index()
  String uid;

  int level_day;
  bool available;
  String? startHour;
  String? endHour;

  final point_relais = ToOne<PointRelais>();

  Schedule({
    this.uid = "",
    required this.level_day,
    this.available = true,
    this.startHour,
    this.endHour,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      uid: json['id'],
      level_day: json['level_day'],
      available: json['available'],
      startHour: json['start_hour'],
      endHour: json['end_hour'],
    );
  }

  Map<String, dynamic> toJson() => {
    'level_day': level_day,
    'available': available,
    'startHour': startHour,
    'endHour': endHour,
  };

  String getTime() {
    if (!available) return "Fermé";
    final debut = parseTimeOfDay(startHour ?? "");
    final fin = parseTimeOfDay(endHour ?? "");
    return "${debut.hour}h${debut.minute > 9 ? "" : "0"}${debut.minute} - ${fin.hour}h${fin.minute > 9 ? "" : "0"}${fin.minute}";
  }
}
