import 'package:dio/dio.dart';

class CutomInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('Request:${options.method} ${options.uri}');
    print('Headers: ${options.headers}');
   handler.next(options);  // to proceed
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    print('Request:${response.statusCode} ${response.requestOptions.uri}');
   handler.next(response);
  }

  @override
  void onError(DioException  err, ErrorInterceptorHandler handler) async {
    print('Error: ${err.message}');
   handler.next(err);
   switch (err.type){
    case DioExceptionType
            .connectionTimeout: //the request that take time to connect
          print('Connection Timeout');
          break;

        case DioExceptionType.badResponse: // 404 kind of error
          print('Bad REsponses');
          break;

        case DioExceptionType
            .receiveTimeout: // the receive data that take time to recieve
          print('Receive Timeout');
          break;

        case DioExceptionType.cancel: // the request that cancel
          print('Cancel REquest');
          break;

        case DioExceptionType
            .sendTimeout: //sending data to server which takes time
          print('Send timeOut');
          break;

        default:
          print('Unexpected Error');
      }
    } 
}