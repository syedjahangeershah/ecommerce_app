import 'package:assessment/app/routes/routes.dart';
import 'package:assessment/pages/main_app/app_state_binding.dart';
import 'package:assessment/pages/main_app/main_app_view.dart';
import 'package:assessment/pages/products/products_view.dart';
import 'package:assessment/pages/products/products_view_binding.dart';
import 'package:assessment/pages/products/products_view_controller.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const initial = Routes.home;

  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const MainApp(),
      binding: AppStateBinding(),
      bindings: [ProductsViewBinding()],
    ),
    GetPage(
      name: Routes.productsScreen,
      page: () => const ProductsView(),
      binding: ProductsViewBinding(),
    ),
  ];
}
