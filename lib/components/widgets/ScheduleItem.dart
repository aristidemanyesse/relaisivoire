import 'package:flutter/material.dart';

class ScheduleItem extends StatelessWidget {
  final String title;
  final String horaire;

  const ScheduleItem({
    super.key,
    required this.title,
    required this.horaire,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          horaire,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
