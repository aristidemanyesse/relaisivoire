import 'package:flutter/material.dart';
import 'package:relaisivoire/components/tools/tools.dart';

class Tip extends StatelessWidget {
  final String text;
  final bool checked;
  final Function() onTap;

  const Tip({
    super.key,
    this.checked = false,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Tools.PADDING / 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Tools.PADDING / 4,
                horizontal: Tools.PADDING / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 0.5),
                color: checked ? MyColors.primary : Colors.white,
              ),
              child: Row(
                children: [
                  if (checked) ...{
                    Icon(Icons.check, size: 20, color: MyColors.secondary),
                    const SizedBox(width: 3),
                  },
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: checked ? MyColors.secondary : MyColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
