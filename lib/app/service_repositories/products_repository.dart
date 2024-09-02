import 'package:assessment/app/api_client/api_client.dart';
import 'package:assessment/app/constants/app_constants.dart';
import 'package:assessment/app/models/product_model.dart';

class ProductsRepository {
  static final apiClient = ApiClient();

  static Future<List<ProductModel>> getProducts({int limit = 50}) async {
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

  static Future<List<ProductModel>> getRelatedProducts(String category,
      {int limit = 10}) async {
    try {
      final response = await apiClient.getData(
        '${AppConstants.relatedProducts}/$category?limit=$limit',
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
}
