import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class EmballageBloc extends StatelessWidget {
  final String subtitle;

  final String title;

  const EmballageBloc({
    super.key,
    required this.subtitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Tools.PADDING),
      child: Card(
        elevation: 1,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Tools.PADDING,
            vertical: Tools.PADDING / 4,
          ),
          decoration: BoxDecoration(
              color: MyColors.beige.withAlpha(200),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1)),
          width: double.infinity,
          height: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
              SizedBox(
                width: Tools.PADDING / 2,
              ),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
