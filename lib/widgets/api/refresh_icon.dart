import 'package:flutter/material.dart';

class RefreshIcon extends StatelessWidget {
  final AnimationController controller;
  final VoidCallback onPressed;

  const RefreshIcon({Key? key, required this.controller, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: IconButton(
        icon: const Icon(Icons.refresh_rounded, color: Colors.blue),
        onPressed: onPressed,
      ),
    );
  }
}
