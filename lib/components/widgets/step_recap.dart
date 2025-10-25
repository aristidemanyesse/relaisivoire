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
      margin: EdgeInsets.only(bottom: Tools.PADDING / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: MyColors.primary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              SizedBox(
                width: 16,
                child: Center(
                  child: Container(
                    height: 45,
                    width: 2,
                    color: MyColors.primary.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: Tools.PADDING),
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
                  ).textTheme.bodyMedium!.copyWith(fontStyle: FontStyle.italic),
                ),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
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
