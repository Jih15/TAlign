import 'package:frontend/app/data/models/auth/auth_model.dart';
import 'package:frontend/app/data/models/auth/signup_request_model.dart';
import 'package:frontend/app/data/models/table/user_model.dart';
import 'package:frontend/app/data/services/auth_services.dart';
import 'package:frontend/app/data/services/student_services.dart';
import 'package:frontend/core/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final AuthServices _authServices = AuthServices();
  final StudentServices _studentServices = StudentServices();

  final Rxn<LoginResponseModel> loginResponse = Rxn<LoginResponseModel>();
  final Rxn<UserModel> signUpResponse = Rxn<UserModel>();
  final isLoggedIn = false.obs;

  Future<void> login(String username, String password) async {
    try {
      // **Hapus data lama sebelum login**
      await GetStorage().erase();
      print('[AUTH] Storage lama dihapus sebelum login');

      final response = await _authServices.login(
          LoginRequestModel(username: username, password: password)
      );

      loginResponse.value = response;

      // Simpan token & user baru
      LocalStorageService.saveToken(response.accessToken);
      LocalStorageService.saveUser(response.user);

      // Ambil data student (menggunakan token baru)
      final student = await _studentServices.getMyData();
      LocalStorageService.saveStudent(student);

      isLoggedIn.value = true;
      print('[AUTH] Login berhasil');
    } catch (e) {
      isLoggedIn.value = false;
      print('[AUTH] Login gagal: $e');
      rethrow;
    }
  }

  Future<void> signUp(String username, String email, String password) async {
    try {
      final response = await _authServices.signUp(
          SignupRequestModel(username: username, email: email, password: password)
      );

      signUpResponse.value = response;
      await login(username, password);

    } catch (e) {
      isLoggedIn.value = false;
      Get.snackbar('SignUp Failed!', e.toString());
    }
  }

  void logout() {
    LocalStorageService.clearAll();
    isLoggedIn.value = false;
  }
}
