import 'package:assessment/pages/products/products_view_controller.dart';
import 'package:get/get.dart';

class ProductsViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsViewController());
  }
}