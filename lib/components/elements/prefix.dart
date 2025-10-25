import 'package:flutter/material.dart';
import 'package:relaisivoire/components/tools/tools.dart';

class Prefix extends StatelessWidget {
  final String text;

  const Prefix({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.primary.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(
        horizontal: Tools.PADDING / 2,
        vertical: Tools.PADDING / 2,
      ),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
