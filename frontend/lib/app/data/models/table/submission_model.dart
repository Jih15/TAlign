class SubmissionModel {
  final int submissionId;
  final int studentId;
  final String title;
  final String titleField;
  final String ideaSource;
  final String? lecturerName;
  final String document;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubmissionModel({
    required this.submissionId,
    required this.studentId,
    required this.title,
    required this.titleField,
    required this.ideaSource,
    this.lecturerName,
    required this.document,
    this.createdAt,
    this.updatedAt,
  });

  factory SubmissionModel.fromJson(Map<String, dynamic> json){
    return SubmissionModel(
      submissionId: json['submission_id'],
      studentId: json['student_id'],
      title: json['title'],
      titleField: json['title_field'],
      ideaSource: json['idea_source'],
      lecturerName: json['lecturer_name'],
      document: json['document'],
    );
  }

  Map<String, dynamic> toJson() => {
    "submission_id": submissionId,
    "student_id": studentId,
    "title": title,
    "title_field": titleField,
    "idea_source": ideaSource,
    "lecturer_name": lecturerName,
    "document": document,
  };
}