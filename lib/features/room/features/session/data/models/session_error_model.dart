// class SessionErrorModel {
//   final int id;
//   final int campaignId;
//   final String title;
//   final int reducedMarks;
//   final bool isRelated;
//   final int? pageNumber;

//   SessionErrorModel({
//     required this.id,
//     required this.campaignId,
//     required this.title,
//     required this.reducedMarks,
//     required this.isRelated,
//     this.pageNumber,
//   });

//   factory SessionErrorModel.fromJson(Map<String, dynamic> json) {
//     return SessionErrorModel(
//       id: json['id'],
//       campaignId: json['campaign_id'],
//       title: json['title'],
//       reducedMarks: json['reduced_marks'],
//       isRelated: json['is_related'],
//       pageNumber: json['pageNumber'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "campaign_id": campaignId,
//       "title": title,
//       "reduced_marks": reducedMarks,
//       "is_related": isRelated,
//       "pageNumber": pageNumber,
//     };
//   }
// }
