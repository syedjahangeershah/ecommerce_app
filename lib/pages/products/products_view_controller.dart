import 'package:assessment/app/models/product_model.dart';
import 'package:assessment/app/service_repositories/products_repository.dart';
import 'package:assessment/pages/main_app/app_state_controller.dart';
import 'package:get/get.dart';

class ProductsViewController extends GetxController {
  final appState = Get.find<AppState>();

  final gettingProducts = false.obs;
  final error = ''.obs;

  final products = <ProductModel>[];

  /// start related Products section ----------
  ///
  final relatedProducts = <ProductModel>[];
  final gettingRelatedProducts = false.obs;
  final relatedProductsError = ''.obs;

  ///
  /// end related product section    ----------

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  Future getProducts() async {
    gettingProducts.value = true;
    error.value = '';
    products.clear();
    try {
      products.addAll(await ProductsRepository.getProducts());
      gettingProducts.value = false;
    } catch (e) {
      gettingProducts.value = false;
      error.value = e.toString();
      Get.snackbar('Error', e.toString());
    }
  }

  Future getRelatedProducts(String category) async {
    gettingRelatedProducts.value = true;
    relatedProductsError.value = '';
    relatedProducts.clear();
    try {
      relatedProducts.addAll(
        await ProductsRepository.getRelatedProducts(category),
      );
      gettingRelatedProducts.value = false;
    } catch (e) {
      gettingRelatedProducts.value = false;
      relatedProductsError.value = e.toString();
      Get.snackbar('Error:', e.toString());
    }
  }
}
