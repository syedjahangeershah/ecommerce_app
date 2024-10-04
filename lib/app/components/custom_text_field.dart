import 'package:assessment/app/constants/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.label,
    required this.prefixIcon,
    this.obscure,
    this.suffixOnTap,
    this.validator,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final IconData prefixIcon;
  final bool? obscure;

  final void Function()? suffixOnTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure ?? false,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.black.withOpacity(.4)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 3.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              prefixIcon,
              color: AppColors.white,
            ),
          ),
        ),
        suffixIcon: obscure == null
            ? null
            : GestureDetector(
                onTap: suffixOnTap,
                child: Icon(
                  obscure == true ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.black,
                ),
              ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(.5),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
      ),
    );
  }
}
