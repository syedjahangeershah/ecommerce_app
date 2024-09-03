import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? color;
  final double? radius, height, width;

  const CustomButton({
    super.key,
    this.onPressed,
    this.child, this.color, this.radius, this.height, this.width,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 45,
      minWidth: width,
      onPressed: onPressed,
      color: color,
      disabledColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 7),
      ),
      child: child,
    );
  }
}
