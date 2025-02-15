import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';

class Wave extends StatelessWidget {
  const Wave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: MyColors.primary,
              border: Border(
                  top: BorderSide(width: 0, color: MyColors.primary),
                  bottom: BorderSide(
                      color: MyColors.secondary.withOpacity(0.5), width: 10))),
          height: double.infinity,
          width: double.infinity,
        ),
        Opacity(
          opacity: 0.15,
          child: Image.asset("assets/images/pattern.png",
              fit: BoxFit.cover, width: Get.width),
        ),
      ],
    );
  }
}
