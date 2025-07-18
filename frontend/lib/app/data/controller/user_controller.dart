import 'package:frontend/app/data/models/table/user_model.dart';
import 'package:frontend/app/data/services/user_services.dart';
import 'package:frontend/core/local_storage_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  final Rxn<UserModel> user = Rxn<UserModel>();

  @override
  void onInit(){
    super.onInit();
    final cached = LocalStorageService.getUser();
    if (cached != null) {
      user.value = cached;
      print('[USER CONTROLLER] Data user dimuat dari cache');
    }
  }

  Future<void> getMyData() async {
    try {
      final user = await UserServices().getMyData();
      LocalStorageService.saveUser(user);
      this.user.value = user;
      print('[USER CONTROLLER] Data user berhasil dimuat');
    } catch (e) {
      print('[USER CONTROLLER] Error: $e]');
    }
  }
}