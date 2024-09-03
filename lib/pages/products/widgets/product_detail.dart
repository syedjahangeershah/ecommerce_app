import 'package:assessment/app/constants/app_color.dart';
import 'package:assessment/app/models/product_model.dart';
import 'package:assessment/app/utils/components/custom_button.dart';
import 'package:assessment/app/utils/components/wish_list_component.dart';
import 'package:assessment/app/utils/functions/toggleFavorite.dart';
import 'package:assessment/pages/cart/cart_view.dart';
import 'package:assessment/pages/products/products_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductsViewController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        forceMaterialTransparency: true,
      ),
      bottomNavigationBar: Container(
        height: 75,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Tooltip(
                message: 'View Cart',
                child: IconButton(
                  onPressed: () => Get.to(() => const CartView()),
                  icon: Obx(() {
                    return Badge.count(
                      count: controller.totalCartItems.value,
                      child: const Icon(Icons.shopping_cart_sharp),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomButton(
                  onPressed: () {
                    controller.cartSheet(product, context);
                  },
                  color: AppColors.black,
                  height: 55,
                  radius: 30,
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: context.height * .3,
              width: double.infinity,
              child: Stack(
                children: [
                  Hero(
                    tag: 'img${product.id!}',
                    child: Image.network(
                      product.image!,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 10,
                    child: Obx(() {
                      final item =
                          controller.appState.productsList.firstWhere(
                        (p) => p.id == product.id,
                      );
                      return WishListComponent(
                        favorite: item.addedToWishList,
                        onTap: () {
                          toggleFavorite(
                            item,
                            controller.appState.wishList,
                            controller.appState.storageService
                          );
                          controller.appState.productsList.refresh();
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Tooltip(
                    message: product.title!,
                    child: Text(
                      product.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Text(
                        'Rs: ${product.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Category: ${product.category}',
                            style: const TextStyle(fontSize: 20),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  const Text('Description:', style: TextStyle(fontSize: 20)),
                  ReadMoreText(
                    '${product.description} ',
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'Read less',
                    moreStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
