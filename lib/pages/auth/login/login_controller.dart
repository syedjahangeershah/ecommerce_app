import 'package:assessment/app/routes/routes.dart';
import 'package:assessment/app/service_repositories/auth_service/auth_service.dart';
import 'package:assessment/app/utils/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final hidePassword = true.obs;
  final loading = false.obs;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      loading.value = true;
      try {
        final loggedIn = await AuthService().login(
          emailController.text,
          passwordController.text,
        );
        if (loggedIn) Get.offAllNamed(Routes.home);
        loading.value = false;
      } catch (e) {
        loading.value = false;
        CustomSnackBar.error(e.toString());
      }
    }
  }
}
