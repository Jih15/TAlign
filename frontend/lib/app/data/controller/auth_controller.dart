import 'package:frontend/app/data/models/auth/login_request_model.dart';
import 'package:frontend/app/data/models/auth/login_response_model.dart';
import 'package:frontend/app/data/services/auth_services.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/utils/services/token.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  final AuthServices _authServices = AuthServices();

  final Rxn<LoginResponseModel> loginResponse = Rxn<LoginResponseModel>();
  final isLoggedIn = false.obs;

  Future<void> login(String username, String password) async {
    try {
      final response = await _authServices.login(
        LoginRequestModel(username: username, password: password)
      );

      loginResponse.value = response;
      saveToken(response.accessToken);
      isLoggedIn.value = true;

    } catch (e) {
      isLoggedIn.value = false;
      rethrow;
    }
  }
}