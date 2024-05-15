import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/keyboard_button.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/keyboard_controller.dart';

class KeyBoardNumber extends StatelessWidget {
  KeyBoardNumber({
    super.key,
  });

  KeyBoradController _keyBoradController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.size.height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: Tools.PADDING),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: Tools.PADDING * 1.5,
          mainAxisSpacing: Tools.PADDING,
          childAspectRatio: 1.0,
        ),
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          if (index == 10) {
            return KeyboardButton(text: "0");
          } else if (index == 9) {
            return Container();
          } else if (index == 11) {
            return IconButton(
              icon: const Icon(
                Icons.backspace,
                color: MyColors.bleu,
              ),
              onPressed: () {
                _keyBoradController.remove();
              },
            );
          } else {
            return KeyboardButton(text: "${index + 1}");
          }
        },
      ),
    );
  }
}
