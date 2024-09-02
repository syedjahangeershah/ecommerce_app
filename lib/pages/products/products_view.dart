import 'package:assessment/pages/products/products_view_controller.dart';
import 'package:assessment/pages/products/widgets/product_card.dart';
import 'package:assessment/pages/products/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsView extends GetView<ProductsViewController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Commerce Store"),
        forceMaterialTransparency: true,
      ),
      body: Obx(() {
        return controller.gettingProducts.value
            ? const Center(child: CircularProgressIndicator())
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
                    onRefresh: () async => await controller.getProducts(),
                    child: ProductsGrid(products: controller.products),
                  );
      }),
    );
  }
}
