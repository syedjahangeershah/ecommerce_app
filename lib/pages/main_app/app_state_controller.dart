import 'package:assessment/pages/products/products_view.dart';
import 'package:assessment/pages/products/products_view_binding.dart';
import 'package:assessment/pages/wish_list/wish_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppState extends GetxController{
  late final PageController pageController;

  int currentPage = 0;

  final pages = [
    const ProductsView(),
    const WishListView(),
  ];


  @override
  void onInit() {
    pageController = PageController(initialPage: currentPage);
    super.onInit();
  }

  void changePage(index, context) {
    if (index != currentPage) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
      currentPage = index;
    }
  }
}