import 'package:dio/dio.dart';
import 'package:myflutterapp/Api/custom_interceptor.dart';
import 'package:myflutterapp/Api/dio_service_class.dart';

class ApiClient implements DioServiceClass {
  late final Dio dio;
  final CancelToken cancelToken = CancelToken();

  ApiClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'https://newsapi.org/v2/top-headlines?',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 5),
          headers: {
            'x-api-key': 'c1388405f46a4cddad56cc380a96fd65', //api key
            'Accept': 'application/json', // accept data in json format
            'Content-Type': 'application/json', // sending data in json format
          },
        ),
      ) {
    dio.interceptors.add(
      CutomInterceptor(),
    ); // it use to manage all request and respone before upper part sends
  }

  @override
  Future<Map<String, dynamic>> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = Uri.parse(
      dio.options.baseUrl,
    ).replace(queryParameters: queryParameters);
    print('Calling API URL: $uri');
    final response = await dio.get(
      '/top-headlines',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}
