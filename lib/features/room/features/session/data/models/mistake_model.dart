// class MistakeModel {
//   final int id;
//   final int page;
//   final String title;

//   MistakeModel({required this.id, required this.page, required this.title});

//   factory MistakeModel.fromJson(Map<String, dynamic> json) {
//     return MistakeModel(
//       id: json['id'] ?? 0,
//       page: json['page'] ?? 0,
//       title: json['title'] ?? '',
//     );
//   }
// }

class MistakeModel {
  final int id;
  final int? pageNumber;
  final String title;
  final int? campaignId;
  final bool? isRelated;
  final int? reducedMarks;
  final int? index;

  MistakeModel({
    required this.id,
    required this.title,
    this.pageNumber,
    this.campaignId,
    this.isRelated,
    this.reducedMarks,
    this.index,
  });

  factory MistakeModel.fromJson(Map<String, dynamic> json) {
    return MistakeModel(
      id: json['id'],
      campaignId: json['campaign_id'],
      title: json['title'],
      reducedMarks: json['reduced_marks'],
      isRelated: json['is_related'],
      pageNumber: json['pageNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "campaign_id": campaignId,
      "title": title,
      "reduced_marks": reducedMarks,
      "is_related": isRelated,
      "pageNumber": pageNumber,
    };
  }

  MistakeModel copyWith({
    int? id,
    int? pageNumber,
    String? title,
    int? campaignId,
    bool? isRelated,
    int? reducedMarks,
    int? index,
  }) {
    return MistakeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      campaignId: campaignId ?? this.campaignId,
      isRelated: isRelated ?? this.isRelated,
      pageNumber: pageNumber ?? this.pageNumber,
      reducedMarks: reducedMarks ?? this.reducedMarks,
      index: index ?? this.index,
    );
  }
}
