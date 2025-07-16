class StudentModel {
  final String nim;
  final String fullName;
  final String majors;
  final String studyProgram;
  final int studentId;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudentModel({
    required this.nim,
    required this.fullName,
    required this.majors,
    required this.studyProgram,
    required this.studentId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    nim: json["nim"],
    fullName: json["full_name"],
    majors: json["majors"],
    studyProgram: json["study_program"],
    studentId: json["student_id"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}