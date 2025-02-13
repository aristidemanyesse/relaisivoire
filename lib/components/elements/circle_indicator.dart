import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class CircleIndicator extends StatelessWidget {
  final String text;

  const CircleIndicator({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.primary),
          color: MyColors.secondary,
          borderRadius: BorderRadius.circular(100)),
      child: Center(
          child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      )),
    );
  }
}
