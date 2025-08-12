import 'package:saas_mosque/features/campaigns/data/models/mosque_model.dart';

class CampaignModel {
  final int id;
  final String? days;
  final String name;
  final MosqueModel? mosque;

  CampaignModel({
    required this.id,
    required this.days,
    required this.name,
    required this.mosque,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      days: json['days'],
      name: json['name'],
      mosque:
          json['mosque'] != null ? MosqueModel.fromJson(json['mosque']) : null,
    );
  }
}
