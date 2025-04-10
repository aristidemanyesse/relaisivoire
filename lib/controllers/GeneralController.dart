import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lpr/services/ApiService.dart';
import 'package:lpr/models/ClientApp/Client.dart';
import 'package:lpr/models/AdministrationApp/CustomUser.dart';

class GeneralController extends GetxController {
  RxBool connected = false.obs;
  RxBool confirmCGU = false.obs;
  RxString token = "".obs;
  RxString refreshToken = "".obs;
  Rx<CustomUser?> utilisateur = Rx<CustomUser?>(null);
  Rx<Client?> client = Rx<Client?>(null);

  @override
  void onInit() {
    confirmCGU.value = false;
    utilisateur.value = null;
    client.value = null;

    // ever(client, (value) {
    //   if (value != "") {
    //     Map<String, dynamic> decodedToken = JwtDecoder.decode(value);
    //   } else {}
    // });

    super.onInit();
  }
}
