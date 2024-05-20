import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/keyboard_controller.dart';

class MyInputNumber extends StatelessWidget {
  const MyInputNumber({
    super.key,
    required KeyBoradController keyBoradController,
  }) : _keyBoradController = keyBoradController;

  final KeyBoradController _keyBoradController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.phone_android,
          size: 30,
        ),
        const SizedBox(width: Tools.PADDING),
        Expanded(
          child: Obx(() {
            List tab = [2, 6];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(10, (index) {
                if (index <= _keyBoradController.value.string.length - 1) {
                  if (tab.contains(index)) {
                    return Container(
                        padding: EdgeInsets.only(left: Tools.PADDING / 2),
                        child: Text(
                            "${_keyBoradController.value.toString()[index]}",
                            style: Theme.of(context).textTheme.displayLarge));
                  } else {
                    return Text(
                        "${_keyBoradController.value.toString()[index]}",
                        style: Theme.of(context).textTheme.displayLarge);
                  }
                } else {
                  if (tab.contains(index)) {
                    return Container(
                      padding: EdgeInsets.only(left: Tools.PADDING / 2),
                      child: Text("_",
                          style: Theme.of(context).textTheme.displayLarge),
                    );
                  } else {
                    return Text("_",
                        style: Theme.of(context).textTheme.displayLarge);
                  }
                }
              }),
            );
          }),
        ),
        const SizedBox(width: Tools.PADDING),
      ],
    );
  }
}
