import 'package:flutter/material.dart';

class ParametreMenuItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function ontap;

  const ParametreMenuItem({
    required this.title,
    required this.ontap,
    this.subtitle = "",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: () {
        ontap();
      },
      title: Text(title, style: Theme.of(context).textTheme.titleSmall),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
