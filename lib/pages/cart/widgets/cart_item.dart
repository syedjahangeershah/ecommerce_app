import 'package:assessment/app/constants/app_color.dart';
import 'package:assessment/app/models/product_model.dart';
import 'package:assessment/pages/products/products_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductsViewController>();
    return SizedBox(
      height: context.height * .15,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Image.network(
                product.image!,
                width: context.width * .3,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.title}',
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(10),
                  Text(
                    'Rs: ${product.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            const Gap(6),
            Container(
              width: 40,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: AppColors.charcole.withOpacity(.6),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final tempItem = ProductModel.fromJson(
                            product.toJson(),
                          );
                          tempItem.qty.value++;
                          controller.updateItem(tempItem);
                        },
                        child: const Icon(Icons.add, color: AppColors.white),
                      ),
                      Text(
                        '${product.qty}',
                        style: const TextStyle(color: AppColors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          final tempItem =
                              ProductModel.fromJson(product.toJson());
                          tempItem.qty.value--;
                          controller.updateItem(tempItem);
                        },
                        child: product.qty.value == 1
                            ? const Icon(Icons.delete, color: Colors.redAccent)
                            : const Icon(Icons.remove, color: AppColors.white),
                      ),
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
