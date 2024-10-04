import 'dart:developer';

import 'package:assessment/app/constants/app_constants.dart';
import 'package:assessment/app/utils/connectivity_check.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._singleton();
  late Dio dio;

  ApiClient._singleton() {
    debugPrint('dio private called');
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
  }

  factory ApiClient() {
    debugPrint('dio factory called');
    return _instance;
  }

  Future<Response> getData(
    String uri, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {

      await ConnectivityCheck().ensureConnectivity();

      debugPrint('GET uri: $uri');
      debugPrint('headers: $headers');
      debugPrint('sending body: $body');

      headers?.addAll({'Accept': 'application/json'});

      Response response = await dio.get(
        uri,
        data: body,
        options: Options(headers: headers),
      );
      log('RESPONSE:: ${response.statusCode} : ${response.data}');
      return response;
    } on DioException catch (e) {
      log('Error:: Dio Exception: status code: ${e.response?.statusCode} - body: ${e.response?.data}');
      throw 'Something went wrong from server side. Please try again!';
    } catch (e) {
      log('Error:: ${e.toString()}');
      throw e.toString();
    }
  }

  Future<Response> postData(
    String uri, {
    required dynamic body,
    Map<String, String>? headers,
  }) async {
    try {

      await ConnectivityCheck().ensureConnectivity();

      debugPrint('POST uri: $uri');
      debugPrint('headers: $headers');
      debugPrint('sending body: $body');

      headers?.addAll({'Accept': 'application/json'});

      Response response = await dio.post(
        uri,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      log('Error:: Dio Exception: status code: ${e.response?.statusCode} - body: ${e.response?.data}');
      throw 'Something went wrong from server side. Please try again!';
    } catch (e) {
      log('Error:: ${e.toString()}');
      throw e.toString();
    }
  }
}
