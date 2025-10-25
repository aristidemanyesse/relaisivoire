import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lpr/components/tools/tools.dart';

class MainButtonIconInverse extends StatelessWidget {
  final IconData? icon;
  final Function onPressed;
  final Color color;

  const MainButtonIconInverse({
    super.key,
    required this.onPressed,
    this.icon = Icons.chevron_right,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Container(
            padding: const EdgeInsets.all(Tools.PADDING / 2),
            decoration: BoxDecoration(color: color, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 30,
                offset: const Offset(0, 5),
              ),
            ]),
            child: Icon(
              icon,
              size: 24,
              color: MyColors.primary,
            ).animate().fade(duration: 500.ms).scale(),
          ),
        ),
      ),
    );
  }
}
