import 'package:assessment/app/constants/app_constants.dart';
import 'package:assessment/app/models/product_model.dart';
import 'package:assessment/app/service_repositories/storage_service/storage_service.dart';

void toggleFavorite(ProductModel product, List<ProductModel> list,
    StorageService storageService) {
  for (var i = 0; i < list.length; i++) {
    if (list[i].id == product.id) {
      product.addedToWishList = false;
      list.removeAt(i);
      storageService.writeData(
        AppConstants.wishList,
        list.map((item) => item.toJson()).toList(),
      );
      return;
    }
  }
  list.add(product);
  product.addedToWishList = true;
  storageService.writeData(
    AppConstants.wishList,
    list.map((item) => item.toJson()).toList(),
  );
}
