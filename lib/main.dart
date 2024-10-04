import 'package:assessment/app/routes/router.dart';
import 'package:assessment/app/routes/routes.dart';
import 'package:assessment/app/service_repositories/storage_service/storage_service.dart';
import 'package:assessment/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    final storageService = StorageService();
    return GetMaterialApp(
      title: 'PieCyfer Assessment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppRoutes.pages,
      home: const SplashPage(),
    );
  }
}
