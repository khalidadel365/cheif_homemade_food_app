import 'package:dio/dio.dart';

class ApiService {
  static Dio? dio;

  void init() {
    dio = Dio(
      BaseOptions(
        //baseUrl: 'https://unsegregated-itchingly-charisse.ngrok-free.dev',
        //baseUrl: 'https://homemadefood.onrender.com',
        baseUrl: 'http://10.0.2.2:8000',
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        receiveDataWhenStatusError: true,
      ),
    );
  }

  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio?.options.headers = {
      if (token != null) 'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };

    var response = await dio!.get(endPoint, queryParameters: queryParameters);

    return response.data;
  }

  Future<Response>? postData({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) {
    dio?.options.headers = {
      'Authorization': token != null ? 'Token $token' : '',
      'Content-Type': 'application/json',
    };
    return dio?.post(endpoint, data: data, queryParameters: query);
  }

  Future<Response>? patchData({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    required String? token,
  }) {
    dio?.options.headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };
    return dio?.patch(endpoint, data: data, queryParameters: query);
  }

  Future<dynamic> delete({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
    dynamic data,
  }) async {
    dio?.options.headers = {
      if (token != null) 'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };

    final response = await dio?.delete(
      endPoint,
      queryParameters: queryParameters,
      data: data,
    );

    return response?.data;
  }
}
