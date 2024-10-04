import 'package:assessment/app/components/custom_button.dart';
import 'package:assessment/app/components/custom_text_field.dart';
import 'package:assessment/app/constants/app_color.dart';
import 'package:assessment/app/routes/routes.dart';
import 'package:assessment/pages/auth/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Center(
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Gap(100),
                CustomTextField(
                  controller: controller.emailController,
                  prefixIcon: Icons.alternate_email,
                  hintText: 'Enter your email',
                ),
                const Gap(20),
                Obx(() {
                  return CustomTextField(
                    controller: controller.passwordController,
                    prefixIcon: Icons.lock,
                    hintText: 'Enter your password',
                    obscure: controller.hidePassword.value,
                    suffixOnTap: controller.hidePassword.toggle,
                  );
                }),
                const Gap(20),
                Obx(() {
                  return CustomTextField(
                    controller: controller.confirmPasswordController,
                    prefixIcon: Icons.lock,
                    hintText: 'Enter your password',
                    obscure: controller.hidePassword.value,
                    suffixOnTap: controller.hidePassword.toggle,
                  );
                }),
                const Gap(20),
                CustomButton(text: 'SIGN UP', onTap: () {
                  Get.offAllNamed(Routes.home);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
