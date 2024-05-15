import 'package:get/get.dart';

class KeyBoradController extends GetxController {
  RxString value = ''.obs;

  void add(String text) {
    value.value = value.value + text;
  }

  void remove() {
    if (value.value.isNotEmpty) {
      value.value = value.value.substring(0, value.value.length - 1);
    }
  }
}
