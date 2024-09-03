import 'package:assessment/app/constants/app_color.dart';
import 'package:assessment/app/constants/app_constants.dart';
import 'package:assessment/app/models/product_model.dart';
import 'package:assessment/app/service_repositories/products_repository.dart';
import 'package:assessment/app/utils/components/custom_button.dart';
import 'package:assessment/pages/main_app/app_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductsViewController extends GetxController {
  final appState = Get.find<AppState>();

  final gettingProducts = false.obs;
  final loadingMore = false.obs;
  final addingToCart = false.obs;
  final error = ''.obs;

  final cart = <ProductModel>[].obs;

  final totalCartItems = 0.obs;
  final totalPrice = 0.0.obs;

  final ScrollController scrollController = ScrollController();
  int limit = 9;

  @override
  void onInit() {
    getProducts();
    getLocalCart();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!gettingProducts.value && !loadingMore.value) {
          limit += 5;
          getProducts(loadMore: true);
        }
      }
    });
    super.onInit();
  }

  Future getProducts({bool reload = false, bool loadMore = false}) async {
    if (loadMore) {
      loadingMore.value = true;
    } else {
      gettingProducts.value = true;
    }
    error.value = '';
    try {
      final response = await ProductsRepository.getProducts(limit: limit);
      if (!reload && !loadMore) {
        // this condition update the item if added to wishlist in local storage
        final wishListJson = appState.storageService.readData<List<dynamic>>(
          AppConstants.wishList,
        );
        if (wishListJson != null) {
          appState.wishList.clear();
          appState.wishList.addAll(
            wishListJson.map(
              (item) => ProductModel.fromJson(item as Map<String, dynamic>),
            ),
          );
        }
      }

      // update wish list status of each product
      for (var product in response) {
        if (appState.wishList.any((item) => item.id == product.id)) {
          product.addedToWishList = true;
        }
      }

      appState.productsList.clear();
      // add api response item to list of products
      appState.productsList.addAll(response);

      gettingProducts.value = false;
      loadingMore.value = false;
    } catch (e) {
      gettingProducts.value = false;
      loadingMore.value = false;
      error.value = e.toString();
      Get.snackbar('Error', e.toString());
    }
  }

  Future addToCart() async {
    try {
      addingToCart.value = true;

      final products = cart.map((item) => {
            'productId': item.id,
            'quantity': item.qty.value,
          });

      final body = {
        'userId': 5,
        'date': DateTime.now().toString().split(' ')[0],
        'products': products
      };
      await ProductsRepository.addToCart(body);
      cart.clear();
      totalCartItems.value = 0;
      totalPrice.value = 0.0;
      addingToCart.value = false;
      Get.back();
      Get.snackbar(
        'Success',
        'Data send successfully!',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      addingToCart.value = false;
      debugPrint('error:: ${e.toString()}');
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

  // read cart from local storage
  void readCart() {
    // final localCartJson = storage.readData(AppConst)
  }

  updateItem(ProductModel product) {
    // check if item is already in cart, then update
    for (var i = 0; i < cart.length; i++) {
      if (cart[i].id == product.id) {
        debugPrint(
            'total:${totalCartItems.value} - ${cart[i].qty.value}, + ${product.qty.value}');
        totalCartItems.value -= cart[i].qty.value;
        if (product.qty.value == 0) {
          cart.removeAt(i);
          calculateTotalPrice();
          saveCart();
          return;
        }
        totalCartItems.value += product.qty.value;
        cart[i] = ProductModel.fromJson(product.toJson());
        calculateTotalPrice();
        saveCart();
        return;
      }
    }
    // otherwise add a new item
    if (product.qty.value == 0) {
      product.qty.value = 1;
      totalCartItems.value++;
    } else {
      totalCartItems.value += product.qty.value;
    }
    cart.add(ProductModel.fromJson(product.toJson()));
    calculateTotalPrice();
    saveCart();
  }

  int getQty(int id) {
    for (var item in cart) {
      if (item.id == id) return item.qty.value;
    }
    return 0;
  }

  void calculateTotalPrice() {
    totalPrice.value = 0.0;
    for (var item in cart) {
      totalPrice.value += (item.qty.value * item.price!);
    }
  }

  void saveCart() {
    final cartJson = cart.map((item) => item.toJson()).toList();
    appState.storageService.writeData(AppConstants.cart, cartJson);
  }

  void getLocalCart() {
    final localCartJson = appState.storageService.readData<List<dynamic>>(
      AppConstants.cart,
    );
    if (localCartJson != null) {
      final a = localCartJson
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>));
      cart.addAll(a);
      for (var item in cart) {
        totalCartItems.value += item.qty.value;
      }
      calculateTotalPrice();
    }
  }

  cartSheet(ProductModel product, BuildContext context) {
    final qty = getQty(product.id!).obs;
    final Rx<num> total = 0.0.obs;
    if (qty.value > 0) {
      total.value += (qty.value * product.price!);
    }
    Get.bottomSheet(
      Container(
        height: Get.height * .4,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: Get.back,
                      child: const Icon(Icons.cancel),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(product.image!, fit: BoxFit.cover),
                      ),
                      const Gap(10),
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
                            const Gap(15),
                            Text(
                              'Rs: ${product.price}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Quantity: ', style: TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (qty.value > 0) {
                                qty.value--;
                                total.value = product.price! * qty.value;
                              }
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.black,
                                ),
                              ),
                              child: const Center(
                                child: Icon(Icons.remove),
                              ),
                            ),
                          ),
                          const Gap(10),
                          Obx(() {
                            return Text(
                              '${qty.value}',
                              style: const TextStyle(fontSize: 16),
                            );
                          }),
                          const Gap(10),
                          GestureDetector(
                            onTap: () {
                              qty.value++;
                              total.value = product.price! * qty.value;
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1, color: AppColors.black),
                              ),
                              child: const Center(
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (qty.value > 0)
                        TextButton.icon(
                          onPressed: () {
                            Get.back();
                            product.qty.value = 0;
                            updateItem(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Item deleted from cart!'),
                                duration: Duration(milliseconds: 700),
                              ),
                            );
                          },
                          label: const Text('Remove from Cart'),
                          icon: const Icon(Icons.delete),
                        ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Obx(() {
                          return Text(
                            'Total Price: Rs. ${total.value}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
              CustomButton(
                onPressed: () {
                  Get.back();
                  product.qty.value = qty.value;
                  updateItem(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cart updated successfully!'),
                      duration: Duration(milliseconds: 700),
                    ),
                  );
                },
                height: 55,
                width: double.infinity,
                radius: 30,
                color: AppColors.black,
                child: Text(
                  qty.value > 0 ? 'Update Item' : 'Add to Cart',
                  style: const TextStyle(color: AppColors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
