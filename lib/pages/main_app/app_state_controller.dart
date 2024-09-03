import 'package:assessment/app/models/product_model.dart';
import 'package:assessment/app/service_repositories/storage_service/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppState extends GetxController{

  final storageService = StorageService();

  late final PageController pageController;

  final currentPage = 0.obs;

  final productsList = <ProductModel>[].obs;
  final wishList = <ProductModel>[].obs;

  @override
  void onInit() {
    pageController = PageController(initialPage: currentPage.value);
    super.onInit();
  }

  void changePage(index, context) {
    if (index != currentPage) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
      currentPage.value = index;
    }
  }
}