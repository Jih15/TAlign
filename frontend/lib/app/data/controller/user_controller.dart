import 'package:frontend/app/data/models/table/user_model.dart';
import 'package:frontend/app/data/services/user_services.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  final UserServices _userServices = UserServices();
  final Rxn<UserModel> user = Rxn<UserModel>();

  Future<void> getMyData() async {
    try {
      final response = await _userServices.getMyData();
      user.value = response;
    } catch (e) {
      rethrow;
    }
  }
}