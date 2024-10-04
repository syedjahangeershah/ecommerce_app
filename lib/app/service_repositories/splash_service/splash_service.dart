import 'package:assessment/app/api_client/api_client.dart';
import 'package:assessment/app/constants/app_constants.dart';
import 'package:assessment/app/models/countries_model.dart';
import 'package:assessment/app/models/user_model.dart';
import 'package:assessment/app/service_repositories/storage_service/storage_service.dart';

class SplashService {
  static final apiClient = ApiClient();
  static final storageService = StorageService();

  static Future<CountriesModel> getCountries() async {
    try {
      final response = await apiClient.getData(
        AppConstants.apiUrl + AppConstants.getAllCountries,
      );
      if (response.statusCode == 200) {
        final countries = CountriesModel.fromJson(response.data);
        return countries;
      } else {
        throw 'Something went wrong. Status Code: E1${response.statusCode}';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
