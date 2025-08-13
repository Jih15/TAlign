class MatchItem {
  final String judulDataset;
  final double similarity;

  MatchItem({required this.judulDataset, required this.similarity});

  factory MatchItem.fromJson(Map<String, dynamic> json) => MatchItem(
    judulDataset: json["judul_dataset"],
    similarity: json["similarity"].toDouble(),
  );
}

class SimilarityResponseModel {
  final String input;
  final String threshold;
  final double similarityScore;
  final List<MatchItem> matches;

  SimilarityResponseModel({
    required this.input,
    required this.threshold,
    required this.similarityScore,
    required this.matches,
  });

  factory SimilarityResponseModel.fromJson(Map<String, dynamic> json) =>
      SimilarityResponseModel(
        input: json["input"],
        threshold: json["threshold"],
        similarityScore: (json["similarity_input"] as num).toDouble(),
        matches: List<MatchItem>.from(
          json["matches"].map((x) => MatchItem.fromJson(x)),
        ),
      );
}
