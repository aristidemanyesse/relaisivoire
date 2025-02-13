import 'package:flutter/material.dart';

class MapButton extends StatelessWidget {
  final Widget widget;

  const MapButton({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(100)),
        child: Center(child: widget),
      ),
    );
  }
}
