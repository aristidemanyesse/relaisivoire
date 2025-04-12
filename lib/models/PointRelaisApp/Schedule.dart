import 'package:flutter/material.dart';
import 'package:lpr/models/PointRelaisApp/PointRelais.dart';
import 'package:objectbox/objectbox.dart';

TimeOfDay parseTimeOfDay(String timeString) {
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
  TimeOfDay? start_hour;
  TimeOfDay? end_hour;

  final point_relais = ToOne<PointRelais>();

  Schedule({
    this.uid = "",
    required this.level_day,
    this.available = true,
    this.start_hour,
    this.end_hour,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      uid: json['id'],
      level_day: json['level_day'],
      available: json['available'],
      start_hour: parseTimeOfDay(json['start_hour'] ?? ""),
      end_hour: parseTimeOfDay(json['end_hour'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        'level_day': level_day,
        'available': available,
        'start_hour': start_hour,
        'end_hour': end_hour,
      };

  String time() {
    return "$start_hour - $end_hour";
  }
}
