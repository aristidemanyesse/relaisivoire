import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/keyboard_controller.dart';

class KeyboardButton extends StatelessWidget {
  final String text;

  KeyboardButton({
    super.key,
    required this.text,
  });

  KeyBoradController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.add(text);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: MyColors.bleu,
              width: 3,
            )),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
