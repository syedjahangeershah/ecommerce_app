import 'package:assessment/pages/main_app/app_state_controller.dart';
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
              children: controller.pages,
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
                      child: const Icon(
                        Icons.home,
                        size: 40,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.changePage(1, context),
                      child: const Icon(
                        Icons.favorite,
                        size: 40,
                      ),
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
