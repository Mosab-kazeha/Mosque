class EvaluationModel {
  final String title;
  final int points;

  EvaluationModel({required this.title, required this.points});

  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      title: json['title'] ?? '',
      points: json['points'] ?? 0,
    );
  }
}
