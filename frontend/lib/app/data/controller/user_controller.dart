import 'dart:io';

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

  // Future<void> updateMyUserData(String profilePic ,String username, String email, String password) async {
  //   try {
  //     final user = await UserServices().updateMyData(username, email, password, profilePic);
  //     this.user.value = user;
  //     print('[USER CONTROLLER] Data user berhasil diupdate');
  //   } catch (e) {
  //     print('[USER CONTROLLER] Error: $e]');
  //   }
  // }
  Future<void> updateMyUserData(
      File? profilePic,
      String username,
      String email,
      String password,
      ) async {
    try {
      final user = await UserServices().updateMyData(
        profilePic:  profilePic,
        username: username,
        email: email,
        password: password,
      );
      this.user.value = user;
      print('[USER CONTROLLER] User data updated');
    } catch (e) {
      print('[USER CONTROLLER] Error: $e');
    }
  }


}