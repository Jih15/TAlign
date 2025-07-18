import 'package:frontend/app/data/models/auth/auth_model.dart';
import 'package:frontend/app/data/services/auth_services.dart';
import 'package:frontend/app/data/services/student_services.dart';
import 'package:frontend/core/local_storage_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  final AuthServices _authServices = AuthServices();
  final StudentServices _studentServices = StudentServices();

  final Rxn<LoginResponseModel> loginResponse = Rxn<LoginResponseModel>();
  final isLoggedIn = false.obs;

  Future<void> login(String username, String password) async {
    try {
      final response = await _authServices.login(
        LoginRequestModel(username: username, password: password)
      );

      loginResponse.value = response;

      LocalStorageService.saveToken(response.accessToken);
      LocalStorageService.saveUser(response.user);

      final student = await _studentServices.getMyData();
      LocalStorageService.saveStudent(student);

      isLoggedIn.value = true;

    } catch (e) {
      isLoggedIn.value = false;
      rethrow;
    }
  }

  void logout() {
    LocalStorageService.clearAll();
    isLoggedIn.value = false;
  }
}