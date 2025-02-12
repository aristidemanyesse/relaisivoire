import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class StepRecap extends StatelessWidget {
  final String subtitle;

  final String title;

  const StepRecap({
    super.key,
    required this.subtitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                  color: MyColors.bleu.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100)),
            ),
            SizedBox(
              width: 16,
              child: Center(
                child: Container(
                  height: 45,
                  width: 2,
                  color: MyColors.bleu.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: Tools.PADDING,
        ),
        SizedBox(
          height: 60,
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontStyle: FontStyle.italic)),
                Text(subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: Tools.PADDING / 2,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
