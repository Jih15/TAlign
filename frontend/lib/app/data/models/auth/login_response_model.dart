// import 'package:frontend/app/data/models/table/user_model.dart';
//
// class LoginResponseModel {
//   final UserModel user;
//   final String accessToken;
//   final String tokenType;
//   final DateTime expiresAt;
//
//   LoginResponseModel({
//     required this.user,
//     required this.accessToken,
//     required this.tokenType,
//     required this.expiresAt
//   });
//
//   factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
//     user: UserModel.fromJson(json["user"]),
//     accessToken: json["access_token"],
//     tokenType: json["token_type"],
//     expiresAt: DateTime.parse(json["expires_at"]),
//   );
// }