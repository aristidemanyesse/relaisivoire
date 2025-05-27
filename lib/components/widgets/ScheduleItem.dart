import 'package:flutter/material.dart';
import 'package:lpr/models/PointRelaisApp/Schedule.dart';

class ScheduleItem extends StatelessWidget {
  final Schedule schedule;

  const ScheduleItem({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Text(
              schedule.level_day == 1
                  ? "Lun"
                  : schedule.level_day == 2
                      ? "Mar"
                      : schedule.level_day == 3
                          ? "Mer"
                          : schedule.level_day == 4
                              ? "Jeu"
                              : schedule.level_day == 5
                                  ? "Ven"
                                  : schedule.level_day == 6
                                      ? "Sam"
                                      : "Dim",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              schedule.getTime(),
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        )
      ],
    );
  }
}
