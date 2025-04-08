import 'package:objectbox/objectbox.dart';

@Entity()
class CustomUser {
  int id = 0;

  @Index()
  String uid;

  String firstName;
  int level;

  CustomUser({
    this.uid = "",
    required this.firstName,
    required this.level,
  });

  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser(
      uid: json['id'],
      firstName: json['firstName'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'level': level,
      };
}
