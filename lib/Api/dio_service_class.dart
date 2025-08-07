
import 'package:dio/dio.dart';

abstract class DioServiceClass {

Dio get dio;

Future<Map<String, dynamic>> getRequest(
  String endpoint, {
  Map<String, dynamic>? queryParameters,
}
);

}

 
