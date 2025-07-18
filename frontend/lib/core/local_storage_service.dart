// import 'package:frontend/app/data/models/table/student_model.dart';
// import 'package:frontend/app/data/models/table/user_model.dart';
// import 'package:get_storage/get_storage.dart';
//
// final box = GetStorage();
//
// // ======================== USER ======================== //
//
// void saveUser(UserModel user) {
//   print('[USER] Menyimpan user: ${user.username}');
//   box.write('user', user.toJson());
// }
//
// UserModel? getUser() {
//   final data = box.read('user');
//   print('[USER] Mengambil user dari storage: $data');
//   if (data == null) return null;
//   // return UserModel.fromJson(Map<String, dynamic>.from(data));
//
//   if (data is Map) {
//     return UserModel.fromJson(Map<String, dynamic>.from(data));
//   } else {
//     print('[USER] Error: data yang diambil bukan Map tapi ${data.runtimeType}');
//     return null;
//   }
// }
//
// void removeUser() => box.remove('user');
//
// // ====================== STUDENT ====================== //
//
// void saveStudent(StudentModel student) {
//   print('[STUDENT] Menyimpan student: ${student.fullName}');
//   box.write('student', student.toJson());
// }
//
// StudentModel? getStudent() {
//   final data = box.read('student');
//   print('[STUDENT] Mengambil student dari storage: $data');
//   if (data == null) return null;
//
//   if (data is Map) {
//     return StudentModel.fromJson(Map<String, dynamic>.from(data));
//   } else {
//     print('[STUDENT] Error: data yang diambil bukan Map tapi ${data.runtimeType}');
//     return null;
//   }
// }
//
// void removeStudent() => box.remove('student');

import 'package:frontend/app/data/models/table/student_model.dart';
import 'package:frontend/app/data/models/table/user_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  static final _box = GetStorage();

  // TOKEN
  static void saveToken(String token) {
    print('[TOKEN] Menyimpan token: $token');
    _box.write('access_token', token);
  }

  static String? getToken() {
    final token = _box.read('access_token');
    print('[TOKEN] Mengambil token dari storage: $token');
    return token;
  }

  static void removeToken()=> _box.remove('access_token');

  // USER
  static void saveUser(UserModel user) {
    print('[USER] Menyimpan user: ${user.username}');
    _box.write('user', user.toJson());
  }

  static UserModel? getUser() {
    final data = _box.read('user');
    if (data is Map) {
      return UserModel.fromJson(Map<String, dynamic>.from(data));
    } else {
      print('[USER] Data tidak valid');
      return null;
    }
  }

  static void removeUser() => _box.remove('user');

  // STUDENT
  static void saveStudent(StudentModel student) {
    print('[STUDENT] Menyimpan student: ${student.fullName}');
    _box.write('student', student.toJson());
  }

  static StudentModel? getStudent() {
    final data = _box.read('student');
    if (data is Map) {
      return StudentModel.fromJson(Map<String, dynamic>.from(data));
    } else {
      print('[STUDENT] Data tidak valid');
      return null;
    }
  }

  static void removeStudent() => _box.remove('student');

  //CLEAR ALL
  static void clearAll(){
    _box.erase();
    print('[LOCAL STORAGE] Data berhasil dihapus');
  }
}
