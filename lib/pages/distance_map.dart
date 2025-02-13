import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class DistanceMap extends StatelessWidget {
  final String text;

  const DistanceMap({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: Tools.PADDING / 3, horizontal: Tools.PADDING / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.social_distance_sharp,
            size: 20,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(text, style: Theme.of(context).textTheme.bodySmall)
        ],
      ),
    );
  }
}
