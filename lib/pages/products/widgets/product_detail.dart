import 'package:assessment/app/models/product_model.dart';
import 'package:assessment/app/utils/components/wish_list_component.dart';
import 'package:assessment/pages/products/products_view_controller.dart';
import 'package:assessment/pages/products/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({super.key, required this.product});

  final ProductModel product;
  final controller = Get.find<ProductsViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        forceMaterialTransparency: true,
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
                    child: WishListComponent(
                      onTap: () {},
                    ),
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
                  ),
                  const Gap(20),
                  const Text(
                    'Related Products:',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Gap(20),
                  Obx(() {
                    return controller.gettingRelatedProducts.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.relatedProductsError.value.isNotEmpty
                            ? Center(
                                child:
                                    Text(controller.relatedProductsError.value))
                            : ProductsGrid(
                                products: controller.relatedProducts,
                                allowScrolling: false,
                              );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
