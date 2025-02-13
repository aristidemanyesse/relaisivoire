import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class Tip extends StatelessWidget {
  final String text;
  final bool checked;
  final IconData icon;

  const Tip({
    super.key,
    this.checked = false,
    this.icon = Icons.check,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: Tools.PADDING / 3, horizontal: Tools.PADDING / 2),
      margin: EdgeInsets.only(right: Tools.PADDING / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 0.5),
        color: checked ? MyColors.primary : Colors.white,
      ),
      child: Row(
        children: [
          Icon(icon,
              size: 20, color: checked ? MyColors.secondary : MyColors.primary),
          const SizedBox(
            width: 3,
          ),
          Text(text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: checked ? MyColors.secondary : MyColors.primary))
        ],
      ),
    );
  }
}
