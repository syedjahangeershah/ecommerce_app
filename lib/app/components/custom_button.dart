import 'package:assessment/app/constants/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height,
    this.width,
    required this.text,
    required this.onTap,
  });

  final double? height, width;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: height ?? 48,
      minWidth: width ?? double.infinity,
      color: AppColors.black,
      child: Text(
        text,
        style: const TextStyle(color: AppColors.white, fontSize: 17),
      ),
    );
  }
}
