import 'package:dio/dio.dart';

// for news App
class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    try {
      Response response = await dio.get(url, queryParameters: query);
      return response;
    } catch (e) {
      print('حدث خطأ: $e');
      throw e;
    }
  }
}
