import 'package:assessment/app/constants/app_color.dart';
import 'package:assessment/app/utils/components/custom_button.dart';
import 'package:assessment/pages/cart/widgets/cart_item.dart';
import 'package:assessment/pages/products/products_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductsViewController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () {
            return controller.cart.isEmpty
                ? const Center(
                    child: Text(
                      'Cart is empty!',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.cart.length,
                    itemBuilder: (context, index) {
                      final product = controller.cart[index];
                      return CartItem(product: product);
                    },
                  );
          },
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Obx(() {
                  return Text(
                    'Rs: ${controller.totalPrice}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  );
                }),
              ],
            ),
          ),
          const Gap(10),
          Obx(() {
            return controller.addingToCart.value
                ? const SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(color: AppColors.black),
                  )
                : controller.totalCartItems.value > 0
                    ? Container(
                        height: 75,
                        width: double.infinity,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomButton(
                            onPressed: controller.addToCart,
                            color: AppColors.black,
                            height: 55,
                            radius: 30,
                            child: const Text(
                              'Place order',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
