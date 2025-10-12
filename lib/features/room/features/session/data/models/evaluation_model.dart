class EvaluationModel {
  final int id;
  // final int campaignId;
  // final bool isRelated;
  final String title;
  final int points;
  final int minimumMarks;

  EvaluationModel({
    required this.id,
    // required this.campaignId,
    // required this.isRelated,
    required this.title,
    required this.points,
    required this.minimumMarks,
  });

  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      id: json['id'],
      // campaignId: json['campaign_id'],
      // isRelated: json['is_related'],
      title: json['title'] ?? '',
      points: json['points'] ?? 0,
      minimumMarks: json['minimum_marks'] ?? 0,
    );
  }
}
