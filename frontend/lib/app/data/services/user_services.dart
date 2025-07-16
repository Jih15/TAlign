import 'package:dio/dio.dart';
import 'package:frontend/app/data/models/table/user_model.dart';
import 'package:frontend/utils/services/dio_client.dart';

class UserServices {
  final Dio _dio = dioClient;

  Future<UserModel> getMyData () async {
    try {
      final response = await _dio.get('users/me');
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = e.response?.data['detail'] ?? 'Error fetch user!';
      throw Exception(errorMessage);
    }
  }
}