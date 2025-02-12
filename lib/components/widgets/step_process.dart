import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class StepProcess extends StatelessWidget {
  final String subtitle;
  final String title;
  final String text;

  const StepProcess({
    super.key,
    required this.subtitle,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: MyColors.bleu),
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                  child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              width: 16,
              child: Center(
                child: Container(
                  height: 35,
                  width: 3,
                  color: MyColors.bleu.withOpacity(0.7),
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
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium),
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
