import 'package:dio/dio.dart';
import 'package:frontend/utils/constant_value.dart';
import 'token.dart';

final Dio dioClient = Dio(
  BaseOptions(
    baseUrl: ConstantsValues.baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    headers: {
      'Content-Type': 'application/json',
    },
  ),
)
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = getToken();
        if (token != null) {
          print('[DIO] Menyisipkan token: Bearer $token');
          options.headers['Authorization'] = 'Bearer $token';
        } else {
          print('[DIO] Tidak ada token ditemukan!');
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        print('[DIO ERROR] ${e.response?.statusCode} - ${e.response?.data}');
        return handler.next(e);
      },
    ),
  );
