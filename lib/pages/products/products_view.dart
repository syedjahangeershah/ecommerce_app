import 'package:assessment/app/constants/app_color.dart';
import 'package:assessment/app/utils/functions/toggleFavorite.dart';
import 'package:assessment/app/utils/shimmers/product_card_shimmer.dart';
import 'package:assessment/pages/cart/cart_view.dart';
import 'package:assessment/pages/products/products_view_controller.dart';
import 'package:assessment/pages/products/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductsView extends GetView<ProductsViewController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Commerce Store"),
        forceMaterialTransparency: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              onPressed: () => Get.to(() => const CartView()),
              icon: Obx(() {
                return Badge.count(
                  count: controller.totalCartItems.value,
                  child: const Icon(Icons.shopping_cart_sharp),
                );
              }),
            ),
          )
        ],
      ),
      body: Obx(() {
        return controller.gettingProducts.value
            ? const Center(child: ProductCardShimmer())
            : controller.error.isNotEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(controller.error.value),
                          TextButton(
                            onPressed: controller.getProducts,
                            child: const Text('Reload'),
                          )
                        ],
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async =>
                        await controller.getProducts(reload: true),
                    child: Obx(() {
                      return SingleChildScrollView(
                        controller: controller.scrollController,
                        child: Column(
                          children: [
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 205,
                                maxCrossAxisExtent: 300,
                              ),
                              padding: const EdgeInsets.all(10),
                              itemCount:
                                  controller.appState.productsList.length,
                              itemBuilder: (context, index) {
                                final product =
                                    controller.appState.productsList[index];
                                return ProductCard(
                                  product: product,
                                  addToWishList: () {
                                    toggleFavorite(
                                      product,
                                      controller.appState.wishList,
                                      controller.appState.storageService,
                                    );
                                    // controller.appState.wishList.refresh();
                                    controller.appState.productsList.refresh();
                                  },
                                );
                              },
                            ),
                            Obx(() {
                              return controller.loadingMore.value
                                  ? const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: CircularProgressIndicator(
                                          color: AppColors.black,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            }),
                            const Gap(100),
                          ],
                        ),
                      );
                    }),
                  );
      }),
    );
  }
}
