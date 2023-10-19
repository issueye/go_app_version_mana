import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class LoggingInterceptor extends Interceptor {
  final Logger logger = Logger('Dio');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.info('Request: ${options.method} ${options.uri}');
    logger.info('Headers: ${options.headers}');
    logger.info('Data: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.info('Response: ${response.statusCode} ${response.requestOptions.uri}');
    logger.info('Headers: ${response.headers}');
    logger.info('Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.severe('Error: ${err.message} ${err.requestOptions.uri}');
    super.onError(err, handler);
  }
}