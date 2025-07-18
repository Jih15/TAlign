import 'package:dio/dio.dart';
import 'package:frontend/app/data/models/table/student_model.dart';
import 'package:frontend/utils/services/dio_client.dart';

class StudentServices {
  final Dio _dio = dioClient;

  Future<StudentModel> getMyData () async {
    try {
      final response = await _dio.get('students/me');
      return StudentModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = e.response?.data['detail'] ?? 'Error fetch student!';
      throw Exception(errorMessage);
    }
  }
}