class GenerateResponseModel {
  final List<String> data;

  GenerateResponseModel({required this.data});

  factory GenerateResponseModel.fromJson(Map<String, dynamic> json) {
    return GenerateResponseModel(
      data: List<String>.from(json['data'] ?? []),
    );
  }
}
