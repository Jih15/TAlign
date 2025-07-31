// import 'package:frontend/app/data/services/user_services.dart';
// import 'package:get_storage/get_storage.dart';
//
// final box = GetStorage();
//
// void saveToken(String token) {
//   print('[TOKEN] Menyimpan token: $token');
//   box.write('access_token', token);
// }
//
// String? getToken() {
//   final token = box.read('access_token');
//   print('[TOKEN] Mengambil token dari storage: $token');
//   return token;
// }
//
// void removeToken() {
//   print('[TOKEN] Menghapus token dari storage');
//   box.remove('access_token');
// }
//
// Future<bool> isAuthenticated() async {
//   final token = getToken();
//   if (token == null || token.isEmpty) {
//     print('[AUTH] Tidak ada token');
//     return false;
//   }
//
//   try {
//     await UserServices().getMyData();
//     print('[AUTH] Token valid, user authenticated');
//     return true;
//   } catch (e) {
//     print('[AUTH] Token tidak valid atau kadaluarsa');
//     removeToken();
//     return false;
//   }
// }