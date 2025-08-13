import 'dart:io';

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


  Future<UserModel> updateMyData({
    File? profilePic,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final formData = FormData();

      formData.fields.addAll([
        MapEntry('username', username),
        MapEntry('email', email),
      ]);

      if (password.isNotEmpty) {
        formData.fields.add(MapEntry('password', password));
      }

      if (profilePic != null) {
        final fileName = profilePic.path.split('/').last;
        formData.files.add(MapEntry(
          'photo',
          await MultipartFile.fromFile(profilePic.path, filename: fileName),
        ));
      }

      final response = await _dio.put(
        'users/me',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = e.response?.data['detail'] ?? 'Error update user!';
      throw Exception(errorMessage);
    }
  }


}