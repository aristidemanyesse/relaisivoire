import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/KeyBoardController.dart';

class KeyboardButton extends StatelessWidget {
  final String text;
  final KeyBoardController controller;
  final int limit;

  const KeyboardButton({
    super.key,
    required this.limit,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (controller.value.value.length < limit) {
              controller.add(text);
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: MyColors.primary,
                  width: 3,
                )),
            child: Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
