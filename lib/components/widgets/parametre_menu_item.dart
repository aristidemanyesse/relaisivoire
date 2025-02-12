import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class ParametreMenuItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function ontap;
  final IconData icon;

  const ParametreMenuItem({
    required this.title,
    required this.ontap,
    required this.icon,
    this.subtitle = "",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: MyColors.bleu, size: 30),
      dense: true,
      onTap: () {
        ontap();
      },
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
