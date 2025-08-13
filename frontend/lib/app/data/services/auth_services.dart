import 'package:dio/dio.dart';
import 'package:frontend/app/data/models/auth/auth_model.dart';
import 'package:frontend/app/data/models/auth/signup_request_model.dart';
import 'package:frontend/app/data/models/table/user_model.dart';
import 'package:frontend/utils/services/dio_client.dart';

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

  Future<UserModel> signUp(SignupRequestModel request) async {
    try {
      print('[AUTH] request signup: ${request.toJson()}');

      final response = await _dio.post(
        'auth/register/student',
        data: request.toJson(),
      );

      print('[AUTH] Response dari server: ${response.data}');

      final newUser = UserModel.fromJson(response.data);
      return newUser;
    } on DioException catch (e) {
      print('[AUTH] Gagal signup: ${e.response?.statusCode} - ${e.response?.data}');
      final errorMessage = e.response?.data['detail'] ?? 'Signup failed!';
      throw Exception(errorMessage);
    } catch (e) {
      print('[AUTH] Unexpected error: $e');
      rethrow;
    }
  }
}
