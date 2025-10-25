import 'package:get/get.dart';

class KeyBoardController extends GetxController {
  RxString value = ''.obs;

  @override
  void onInit() {
    value.value = "";
    super.onInit();
  }

  void add(String text) {
    value.value = value.value + text;
  }

  void remove() {
    if (value.value.isNotEmpty) {
      value.value = value.value.substring(0, value.value.length - 1);
    }
  }
}
