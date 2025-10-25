import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:relaisivoire/components/tools/tools.dart';

class MainButtonInverse extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function onPressed;

  const MainButtonInverse({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon = Icons.chevron_right,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: MyColors.primary.withOpacity(0.5),
              blurRadius: 30,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 10,
            shadowColor: MyColors.primary.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING / 1.5,
              vertical: Tools.PADDING / 2,
            ),
            backgroundColor: MyColors.primary,
            foregroundColor: MyColors.secondary,
          ),
          onPressed: () {
            onPressed();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: MyColors.secondary,
                ),
              ),
              const SizedBox(width: Tools.PADDING / 3),
              icon != null
                  ? Icon(
                      icon,
                      color: MyColors.secondary,
                    ).animate().fade(duration: 500.ms).scale()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
