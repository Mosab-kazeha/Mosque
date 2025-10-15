class CurriculumCampaignModel {
  final int id;
  final String name;

  const CurriculumCampaignModel({required this.id, required this.name});

  factory CurriculumCampaignModel.fromJson(Map<String, dynamic> json) {
    return CurriculumCampaignModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
