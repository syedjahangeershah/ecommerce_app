import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
}