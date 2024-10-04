class CountriesModel {
  bool? success;
  int? code;
  String? message;
  List<CountriesData>? data;

  CountriesModel({this.success, this.code, this.message, this.data});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CountriesData>[];
      json['data'].forEach((v) {
        data!.add(CountriesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountriesData {
  int? id;
  String? title;
  String? image;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  CountriesData(
      {this.id,
        this.title,
        this.image,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  CountriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
