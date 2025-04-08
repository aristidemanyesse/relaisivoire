import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lpr/components/tools/apiservice.dart';
import 'package:lpr/models/ClientApp/Client.dart';

class GeneralController extends GetxController {
  RxBool confirmCGU = false.obs;
  RxString token = "".obs;
  RxString refreshToken = "".obs;
  Rx<Client?> utilisateur = Rx<Client?>(null);

  @override
  void onInit() {
    confirmCGU.value = false;
    utilisateur.value = Client(contact: "");

    ever(token, (value) {
      print("Token changed: $value");
      if (value != "") {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(value);
        print(decodedToken);
        // ApiService.get('api/client/');
      } else {}
    });

    super.onInit();
  }
}
