import 'package:assessment/app/constants/app_constants.dart';
import 'package:assessment/app/models/user_model.dart';
import 'package:assessment/app/routes/routes.dart';
import 'package:assessment/app/service_repositories/splash_service/splash_service.dart';
import 'package:assessment/app/service_repositories/storage_service/storage_service.dart';
import 'package:assessment/app/utils/custom_snackbar.dart';
import 'package:assessment/pages/country_selection/country_selection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storageService = StorageService();

  @override
  void initState() {
    initProcess();
    super.initState();
  }

  Future initProcess() async {
    final isLoggedIn = storageService.readData<bool?>(AppConstants.loggedIn);
    if (isLoggedIn == true) {
      final country = storageService.readData<String?>(AppConstants.country);
      if (country == null) {
        try {
          // Get Countries
          final countries = await SplashService.getCountries();
          Get.offAll(() => CountrySelection(countries: countries));
        } catch (e) {
          CustomSnackBar.error(e.toString());
        }
        return;
      }
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
