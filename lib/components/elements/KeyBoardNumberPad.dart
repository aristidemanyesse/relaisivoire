import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/keyboard_button.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/KeyBoardController.dart';

class KeyBoardNumberPad extends StatelessWidget {
  final int limit;
  KeyBoardNumberPad({
    required this.limit,
    super.key,
  });

  KeyBoardController keyBoardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: Tools.PADDING * 1.5,
        mainAxisSpacing: Tools.PADDING,
        childAspectRatio: 1.0,
      ),
      itemCount: 12,
      itemBuilder: (BuildContext context, int index) {
        if (index == 10) {
          return KeyboardButton(
            text: "0",
            limit: limit,
            controller: keyBoardController,
          );
        } else if (index == 9) {
          return Container();
        } else if (index == 11) {
          return IconButton(
            icon: const Icon(
              Icons.backspace,
              color: MyColors.textprimary,
            ),
            onPressed: () {
              keyBoardController.remove();
            },
          );
        } else {
          return KeyboardButton(
              limit: limit,
              controller: keyBoardController,
              text: "${index + 1}");
        }
      },
    );
  }
}
