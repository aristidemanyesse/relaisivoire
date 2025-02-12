import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class TypeDestinataireBloc extends StatelessWidget {
  final String subtitle;
  final String title;
  final IconData icon;

  const TypeDestinataireBloc({
    super.key,
    required this.subtitle,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Tools.PADDING / 2,
          vertical: Tools.PADDING / 4,
        ),
        decoration: BoxDecoration(
            color: MyColors.beige.withAlpha(200),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5)),
        width: double.infinity,
        height: 65,
        child: Row(
          children: [
            Icon(icon, size: 45, color: MyColors.bleu),
            const SizedBox(
              width: Tools.PADDING,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  const SizedBox(
                    width: Tools.PADDING / 2,
                  ),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
