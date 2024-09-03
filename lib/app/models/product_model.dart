import 'package:get/get.dart';

class ProductModel {
  int? id;
  String? title;
  num? price;
  String? category;
  String? description;
  String? image;

  // These variables are being used within the app (not related to API)
  final qty = 0.obs;
  bool addedToCart = false;
  bool addedToWishList = false;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.category,
    this.description,
    this.image,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    category = json['category'];
    description = json['description'];
    image = json['image'];
    qty.value = json['qty'] ?? 0;
    addedToCart = json['addedToCart'] ?? false;
    addedToWishList = json['addedToWishList'] ?? false;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['category'] = category;
    data['description'] = description;
    data['image'] = image;
    data['addedToCart'] = addedToCart;
    data['qty'] = qty.value;
    data['addedToWishList'] = addedToWishList;
    return data;
  }
}
