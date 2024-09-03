import 'package:assessment/app/api_client/api_client.dart';
import 'package:assessment/app/constants/app_constants.dart';
import 'package:assessment/app/models/product_model.dart';

class ProductsRepository {
  static final apiClient = ApiClient();

  static Future<List<ProductModel>> getProducts({int limit = 8}) async {
    try {
      final response = await apiClient.getData(
        '${AppConstants.products}?limit=$limit',
      );
      final List<ProductModel> products = (response.data as List<dynamic>)
          .map(
            (item) => ProductModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
      return products;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> addToCart(dynamic body) async {
    try {
      final response = await apiClient.postData(AppConstants.carts, body: body);
      if (response.statusCode != 200) throw 'Not able to post data';
    } catch (e) {
      throw e.toString();
    }
  }
}
