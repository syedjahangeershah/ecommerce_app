
import 'package:assessment/app/api_client/api_client.dart';
import 'package:assessment/app/constants/app_constants.dart';
import 'package:assessment/app/models/user_model.dart';
import 'package:assessment/app/service_repositories/storage_service/storage_service.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final apiClient = ApiClient();
  final _storageService = StorageService();

  Future<bool> login(String userName, String password) async {
    Map<String, dynamic> body = {
      "email": userName,
      "password": password,
    };
    try {
      debugPrint('body: $body');
      final response = await apiClient.postData(
        AppConstants.apiUrl + AppConstants.customerLogin,
        body: body,
      );
      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data);
        _storageService.writeData(AppConstants.user, user.toJson());
        _storageService.writeData(AppConstants.loggedIn, true);
        return true;
      } else {
        throw 'Unable to login. Server Message: ${response.data?['message']}';
      }
    } catch (e) {
      throw e.toString();
    }
  }

}