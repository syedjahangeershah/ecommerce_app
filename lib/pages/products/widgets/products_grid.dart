import 'package:assessment/app/models/product_model.dart';
import 'package:assessment/pages/products/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
    required this.products,
    this.allowScrolling = true,
  });

  final List<ProductModel> products;
  final bool allowScrolling;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: allowScrolling
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 205,
        maxCrossAxisExtent: 300,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(product: product);
      },
    );
  }
}
