import 'package:assessment/app/utils/functions/toggleFavorite.dart';
import 'package:assessment/pages/main_app/app_state_controller.dart';
import 'package:assessment/pages/products/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        forceMaterialTransparency: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              ...List.generate(
                12,
                (index) => Column(
                  children: [
                    Container(
                      width: (context.width - 50) * .25,
                      height: (context.width - 50) * .25,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: (context.width - 50) * .25,
                      child: Center(child: Text('Category $index')),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
