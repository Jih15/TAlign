import 'package:dio/dio.dart';
import 'package:frontend/app/data/models/auth/login_request_model.dart';
import 'package:frontend/app/data/models/auth/login_response_model.dart';
import 'package:frontend/utils/services/dio_client.dart';
import 'package:frontend/utils/services/token.dart';

class AuthServices {
  final Dio _dio = dioClient;

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      print('[AUTH] Mengirim request login: ${request.toJson()}');

      final response = await _dio.post(
        'auth/login',
        data: request.toJson(),
      );

      print('[AUTH] Response dari server: ${response.data}');

      final loginResponse = LoginResponseModel.fromJson(response.data);
      print('[AUTH] Token diterima: ${loginResponse.accessToken}');

      saveToken(loginResponse.accessToken);
      return loginResponse;

    } on DioException catch (e) {
      print('[AUTH] Gagal login: ${e.response?.statusCode} - ${e.response?.data}');
      final errorMessage = e.response?.data['detail'] ?? 'Login failed!';
      throw Exception(errorMessage);
    } catch (e) {
      print('[AUTH] Unexpected error: $e');
      rethrow;
    }
  }
}
