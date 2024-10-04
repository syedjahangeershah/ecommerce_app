import 'package:assessment/app/routes/routes.dart';
import 'package:assessment/pages/auth/login/login_binding.dart';
import 'package:assessment/pages/auth/login/login_view.dart';
import 'package:assessment/pages/auth/sign_up/sign_up_binding.dart';
import 'package:assessment/pages/auth/sign_up/sign_up_view.dart';
import 'package:assessment/pages/main_app/app_state_binding.dart';
import 'package:assessment/pages/main_app/main_app_view.dart';
import 'package:assessment/pages/products/products_view.dart';
import 'package:assessment/pages/products/products_view_binding.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const initial = Routes.login;

  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
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
