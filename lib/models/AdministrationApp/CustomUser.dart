import 'package:get/get.dart';
import 'package:relaisivoire/services/ApiService.dart';
import 'package:relaisivoire/controllers/GeneralController.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CustomUser {
  @Id(assignable: true)
  int id = 0;

  String? firstName;
  String? lastName;
  String? fcmtoken;

  CustomUser({
    this.id = 0,
    this.firstName = "",
    this.lastName = "",
    this.fcmtoken = "",
  });

  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      fcmtoken: json['fcm_token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'fcm_token': fcmtoken,
  };

  static Future<bool> ifUserExists(String username) async {
    Map<String, dynamic> response = await ApiService.get(
      'api/custom_users/search-by-username/?username=$username',
    );
    if (response["status"] && response["data"].length > 0) {
      return true;
    }
    return false;
  }

  static Future<bool> connexion(String username) async {
    Map<String, dynamic> response = await ApiService.post('api/auth/login/', {
      'username': username,
      'password': username,
    });
    if (response["status"] && response["data"].containsKey('access')) {
      GeneralController controller = Get.find();
      controller.token.value = response["data"]['access'];
      controller.refreshToken.value = response["data"]['refresh'];
      return true;
    }
    return false;
  }

  // ✅ Méthode d'instance : mini résumé
  static void genereOtp(String username, String signature) async {
    ApiService.post('api/custom_users/genere-otp/', {"signature": signature});
  }

  // ✅ Méthode d'instance : mini résumé
  static Future<bool> verifyOtp(String username, String otp) async {
    Map<String, dynamic> response = await ApiService.post(
      'api/custom_users/verify-otp/',
      {"username": username, "otp": otp},
    );
    if (response['status']) {
      return true;
    }
    return false;
  }

  Future<CustomUser?> update(Map<String, dynamic> variables) async {
    Map<String, dynamic> response = await ApiService.patch(
      'api/custom_users/$id/',
      variables,
    );
    if (response["status"] && response["data"] != null) {
      CustomUser user = CustomUser.fromJson(response["data"]);
      return user;
    }
    return null;
  }

  Future<bool> changeCredentials(String username, String password) async {
    Map<String, dynamic> response = await ApiService.post(
      'api/custom_users/change-credentials/',
      {'username': username, 'password': password},
    );
    if (response["status"] && response["data"] != null) {
      return true;
    }
    return false;
  }
}
