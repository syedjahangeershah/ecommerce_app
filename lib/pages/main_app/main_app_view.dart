import 'package:assessment/app/constants/app_color.dart';
import 'package:assessment/pages/main_app/app_state_controller.dart';
import 'package:assessment/pages/products/products_view.dart';
import 'package:assessment/pages/wish_list/wish_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainApp extends GetView<AppState> {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const ProductsView(),
          WishListView(appState: controller),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          selectedItemColor: AppColors.black,
          currentIndex: controller.currentPage.value,
          onTap: (index) => controller.changePage(index, context),
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                controller.currentPage.value == 0
                    ? Icons.home
                    : Icons.home_outlined,
                size: 40,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Categories',
              icon: Icon(
                controller.currentPage.value == 1
                    ? Icons.category
                    : Icons.category_outlined,
                size: 40,
              ),
            ),
          ],
        );
      }),
    );
  }
}
