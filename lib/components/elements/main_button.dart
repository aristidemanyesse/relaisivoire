import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:relaisivoire/components/tools/tools.dart';

class MainButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  final bool forward;

  const MainButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon = Icons.chevron_right,
    this.forward = true,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: MyColors.secondary.withOpacity(0.5),
              blurRadius: 30,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 10,
            shadowColor: Colors.grey.withOpacity(0.7),
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING / 1.5,
              vertical: Tools.PADDING / 2,
            ),
            backgroundColor: MyColors.secondary,
            foregroundColor: MyColors.textprimary,
          ),
          onPressed: () {
            onPressed();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (!forward) ...{
                Icon(icon).animate().fade(duration: 500.ms).scale(),
                const SizedBox(width: Tools.PADDING / 2),
              },
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: MyColors.textprimary,
                ),
              ),
              if (forward) ...{
                const SizedBox(width: Tools.PADDING / 2),
                Icon(icon).animate().fade(duration: 500.ms).scale(),
              },
            ],
          ),
        ),
      ),
    );
  }
}
