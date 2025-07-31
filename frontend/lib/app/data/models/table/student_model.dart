class StudentModel {
  final int? nim;
  final String fullName;
  final String? majors;
  final String? studyProgram;
  final int? studentId;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  StudentModel({
    this.nim,
    required this.fullName,
    this.majors,
    this.studyProgram,
    this.studentId,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    nim: json["nim"],
    fullName: json["full_name"] ?? '',
    majors: json["majors"],
    studyProgram: json["study_program"],
    studentId: json["student_id"],
    userId: json["user_id"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "nim": nim,
    "full_name": fullName,
    "majors": majors,
    "study_program": studyProgram,
    "student_id": studentId,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
