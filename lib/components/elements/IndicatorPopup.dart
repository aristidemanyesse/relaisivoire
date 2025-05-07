import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndicatorPopup extends StatelessWidget {
  const IndicatorPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: SizedBox(
        height: 30,
        width: double.infinity,
        child: Center(
          child: Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
    );
  }
}
