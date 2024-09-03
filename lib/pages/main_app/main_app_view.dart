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
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const ProductsView(),
                WishListView(appState: controller),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Color(0x19000000),
                      offset: Offset(0.0, 2.0),
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => controller.changePage(0, context),
                      child: Obx(() {
                        return Icon(
                          controller.currentPage.value == 0
                              ? Icons.home
                              : Icons.home_outlined,
                          size: 40,
                        );
                      }),
                    ),
                    GestureDetector(
                      onTap: () => controller.changePage(1, context),
                      child: Obx(() {
                        return Icon(
                          controller.currentPage.value == 1
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 40,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
