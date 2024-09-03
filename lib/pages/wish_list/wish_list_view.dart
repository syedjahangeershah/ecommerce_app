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
        title: const Text("Wish List"),
        forceMaterialTransparency: true,
        elevation: 1,
      ),
      body: Obx(() {
        return GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 205,
            maxCrossAxisExtent: 300,
          ),
          padding: const EdgeInsets.all(10),
          itemCount: appState.wishList.length,
          itemBuilder: (context, index) {
            final product = appState.wishList[index];
            return ProductCard(
              product: product,
              addToWishList: () {
                toggleFavorite(
                  product,
                  appState.wishList,
                  appState.storageService,
                );
                appState.wishList.refresh();
              },
            );
          },
        );
      }),
    );
  }
}
