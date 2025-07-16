import 'package:frontend/app/data/models/table/user_model.dart';

class LoginResponseModel {
  final UserModel user;
  final String accessToken;
  final String tokenType;

  LoginResponseModel({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    user: UserModel.fromJson(json["user"]),
    accessToken: json["access_token"],
    tokenType: json["token_type"],
  );
}