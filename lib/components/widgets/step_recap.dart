import 'package:flutter/material.dart';
import 'package:relaisivoire/components/tools/tools.dart';

class StepRecap extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? subtitle2;

  const StepRecap({
    super.key,
    required this.subtitle,
    required this.title,
    this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Tools.PADDING),
      constraints: const BoxConstraints(minHeight: 30),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: MyColors.primary.withOpacity(0.5), width: 3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: Tools.PADDING / 2),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontStyle: FontStyle.italic),
                ),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                if (subtitle2 != null)
                  Text(
                    subtitle2 ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
