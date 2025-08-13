class UserModel {
  final int userId;
  final String username;
  final String email;
  final String role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? profilePicture;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.role,
    this.createdAt,
    this.updatedAt,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["user_id"] is int
          ? json["user_id"]
          : int.tryParse(json["user_id"].toString()) ?? 0,
      username: json["username"] ?? '',
      email: json["email"] ?? '',
      role: json["role"] ?? '',
      profilePicture: json["profile_picture"] ?? '',
      createdAt: json["created_at"] != null
          ? DateTime.tryParse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.tryParse(json["updated_at"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "username": username,
    "email": email,
    "role": role,
    "profile_picture": profilePicture,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
