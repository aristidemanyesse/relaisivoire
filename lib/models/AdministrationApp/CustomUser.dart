import 'package:get/get.dart';
import 'package:lpr/services/ApiService.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CustomUser {
  int id = 0;

  @Index()
  String uid;

  String? firstName;
  String? lastName;

  CustomUser({
    this.uid = "",
    this.firstName,
    this.lastName,
  });

  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser(
      uid: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
      };

  static Future<bool> connexion(String username) async {
    Map<String, dynamic> response = await ApiService.post(
        'api/auth/login/', {'username': username, 'password': username});
    if (response["status"] && response["data"].containsKey('access')) {
      GeneralController controller = Get.find();
      controller.token.value = response["data"]['access'];
      controller.refreshToken.value = response["data"]['refresh'];
      return true;
    }
    return false;
  }

  // ✅ Méthode d'instance : mini résumé
  static void genereOtp(String username) async {
    ApiService.post('api/custom_users/genere-otp/', {"username": username});
  }

  // ✅ Méthode d'instance : mini résumé
  static Future<bool> verifyOtp(String username, String otp) async {
    Map<String, dynamic> response = await ApiService.post(
        'api/custom_users/verify-otp/', {"username": username, "otp": otp});
    if (response['status']) {
      return true;
    }
    return false;
  }
}
