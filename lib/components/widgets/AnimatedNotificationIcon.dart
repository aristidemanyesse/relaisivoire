import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedNotificationIcon extends StatefulWidget {
  final int count;
  final VoidCallback onTap;

  const AnimatedNotificationIcon({
    super.key,
    required this.count,
    required this.onTap,
  });

  @override
  State<AnimatedNotificationIcon> createState() =>
      _AnimatedNotificationIconState();
}

class _AnimatedNotificationIconState extends State<AnimatedNotificationIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _shakeTimer;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _manageTimer();
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.3), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.3, end: 0.3), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 0.0), weight: 1),
    ]).animate(_controller);
  }

  void _startShakeLoop() {
    _shakeTimer?.cancel();
    _shakeTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _controller.forward(from: 0.0);
    });
  }

  void _stopShakeLoop() {
    _shakeTimer?.cancel();
  }

  void _manageTimer() {
    if (widget.count > 0) {
      _startShakeLoop();
    } else {
      _stopShakeLoop();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedNotificationIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count != oldWidget.count) {
      _manageTimer();
    }
  }

  @override
  void dispose() {
    _stopShakeLoop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value,
            child: Stack(
              children: [
                const Icon(Icons.notifications, size: 30),
                if (widget.count > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints:
                          const BoxConstraints(minWidth: 10, minHeight: 10),
                      child: Text(
                        '${widget.count}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 6,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
