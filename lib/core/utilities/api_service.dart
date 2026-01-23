import 'package:dio/dio.dart';

class ApiService {
  static Dio? dio ;

  init (){
    dio = Dio(
      BaseOptions(
        //'http://10.0.2.2:8000'
        baseUrl: 'http://10.0.2.2:8000',
        receiveDataWhenStatusError: true
      )
    );
  }

  // static Future<Response>? getData({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   String? lang = 'en',
  //   String? token ,
  // }){
  //   dio?.options.headers = {
  //     'lang' : lang,
  //     'Authorization': token ?? '',
  //     'Content-Type' : 'application/json',
  //   };
  //   return dio?.get(
  //       url,  //Method (Which table will get from)
  //       queryParameters: query
  //   );
  // }

  Future<Response>? postData({
    required String endpoint, //endpoint
    required Map<String,dynamic> data,
    Map<String,dynamic>? query,
    String lang = 'en',
    String?  token
  }
      ){
    dio?.options.headers={
      'lang':lang,
      'Authorization':token?? '', //mlosh lazma fe el login // lw feh het7at
      'Content-Type' : 'application/json',
    };
    return dio?.post(
        endpoint,
        data: data,
    );
  }
  Future<Map<String,dynamic>> get ({
    required String endPoint,
  })async{
    var response = await dio?.get('$endPoint');
    print(response!.data);
    return response.data;
  }
}