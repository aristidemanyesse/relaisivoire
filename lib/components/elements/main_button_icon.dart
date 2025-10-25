import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:relaisivoire/components/tools/tools.dart';

class MainButtonIcon extends StatelessWidget {
  final IconData? icon;
  final Function onPressed;
  final Color color;

  const MainButtonIcon({
    super.key,
    required this.onPressed,
    this.icon = Icons.chevron_right,
    this.color = MyColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 30,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shadowColor: color.withOpacity(0.2),
              backgroundColor: color,
              foregroundColor: MyColors.secondary,
            ),
            onPressed: () {
              onPressed();
            },
            child: Icon(
              icon,
              size: 27,
              color: MyColors.secondary,
            ).animate().fade(duration: 500.ms).scale(),
          ),
        ),
      ),
    );
  }
}
