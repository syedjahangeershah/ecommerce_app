import 'package:assessment/app/components/custom_button.dart';
import 'package:assessment/app/components/custom_text_field.dart';
import 'package:assessment/app/constants/app_color.dart';
import 'package:assessment/app/routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:assessment/pages/auth/login/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // backgroundColor: AppColors.black,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const Gap(100),
                  CustomTextField(
                    controller: controller.emailController,
                    prefixIcon: Icons.alternate_email,
                    hintText: 'Enter your email',
                    validator: (value) {
                      if (controller.emailController.text.isEmpty) {
                        return 'Please enter the email';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  Obx(() {
                    return CustomTextField(
                      controller: controller.passwordController,
                      prefixIcon: Icons.lock,
                      hintText: 'Enter your password',
                      obscure: controller.hidePassword.value,
                      suffixOnTap: controller.hidePassword.toggle,
                      validator: (value) {
                        if (controller.passwordController.text.isEmpty) {
                          return 'Please enter the password';
                        }
                        return null;
                      },
                    );
                  }),
                  const Gap(20),
                  Obx(() {
                    return controller.loading.value
                        ? const SizedBox(
                            height: 48,
                            width: 48,
                            child: CircularProgressIndicator(
                              color: AppColors.black,
                            ),
                          )
                        : CustomButton(text: 'LOGIN', onTap: controller.login);
                  }),
                  const Gap(30),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Not registered yet? ',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: 'Register Now',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(Routes.signUp),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
