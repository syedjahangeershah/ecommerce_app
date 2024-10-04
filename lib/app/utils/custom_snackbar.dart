import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static void error(String error) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        'Error',
        error,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  static void success(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        'Success',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
