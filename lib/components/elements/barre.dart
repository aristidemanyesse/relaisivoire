import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class Barre extends StatelessWidget {
  const Barre({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 5,
        width: double.infinity,
        color: MyColors.beige,
      ),
    );
  }
}

class BarreVerticale extends StatelessWidget {
  const BarreVerticale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 5,
        color: MyColors.bleu,
      ),
    );
  }
}
