import 'package:dio/dio.dart';
import 'package:bookly_app/app/constants.dart';

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      'Cache-Control': 'no-cache',
    };
    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: headers,
        receiveTimeout: const Duration(milliseconds: Constants.API_TIME_OUT),
        sendTimeout: const Duration(milliseconds: Constants.API_TIME_OUT));

    // if(!kReleaseMode){ //debug mode
    //   dio.interceptors.add(PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: true,
    //   ));
    // }
    return dio;
  }
}
