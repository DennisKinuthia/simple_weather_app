import 'package:flutter/material.dart';

class BorderBox extends StatelessWidget {
  const BorderBox(
      {super.key,
      required this.width,
      required this.height,
      this.padding,
      this.circle = true,
      required this.child});

  final double width;
  final double height;
  final EdgeInsets? padding;
  final Widget child;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(0),
      decoration: circle
          ? BoxDecoration(
              color: const Color.fromARGB(255, 31, 43, 71),
              border: Border.all(
                width: 1.0,
                color: Colors.blueGrey.withOpacity(0.6),
              ),
              borderRadius: BorderRadius.circular(50.0),
            )
          : null,
      child: child,
    );
  }
}
