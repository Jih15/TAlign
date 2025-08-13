import 'package:dio/dio.dart';
import 'package:frontend/core/local_storage_service.dart';
import 'package:frontend/utils/constant_value.dart';

final Dio dioClient = Dio(
  BaseOptions(
    baseUrl: ConstantsValues.baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    headers: {
      'Content-Type': 'application/json',
    },
  ),
)
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = LocalStorageService.getToken();
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
