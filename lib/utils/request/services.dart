import 'package:dio/dio.dart';
import './apiInterceptor.dart';
import './wrapperInterceptor.dart';
import 'loggingInterceptor.dart';

class DioSingleton {
  static Dio? _dioInstance;
  DioSingleton._(); // 私有的构造函数

  static String baseUrl = '';

  static Dio get instance {
    _dioInstance ??= Dio();

    // 添加拦截器
    _dioInstance!.interceptors.add(ApiInterceptor());
    _dioInstance!.interceptors.add(WrapperInterceptor());
    _dioInstance!.interceptors.add(LoggingInterceptor());
    // 设置超时时间
    _dioInstance!.options.connectTimeout =
        const Duration(milliseconds: 5000); // 连接超时时间为5秒
    _dioInstance!.options.receiveTimeout =
        const Duration(milliseconds: 3000); // 接收超时时间为3秒
    _dioInstance!.options.baseUrl = baseUrl;

    return _dioInstance!;
  }

  static Future<Response> getData(String url,
      {Map<String, dynamic>? params}) async {
    var d = DioSingleton.instance;
    try {
      final response = await d.get(url, queryParameters: params);
      return response;
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  static Future<Response> postData(String url, dynamic data) async {
    var d = DioSingleton.instance;
    try {
      final response = await d.post(
        url,
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response;
    } catch (error) {
      throw Exception('Failed to post data');
    }
  }

  static Future<Response> deleteData(String url) async {
    var d = DioSingleton.instance;
    try {
      final response = await d.delete(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response;
    } catch (error) {
      throw Exception('Failed to post data');
    }
  }
}
