import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class Circle extends StatelessWidget {
  const Circle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          color: MyColors.secondary, borderRadius: BorderRadius.circular(100)),
    );
  }
}

class CircleInverse extends StatelessWidget {
  const CircleInverse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          color: MyColors.primary, borderRadius: BorderRadius.circular(100)),
    );
  }
}
