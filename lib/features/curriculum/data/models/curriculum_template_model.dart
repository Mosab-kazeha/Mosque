import 'package:saas_mosque/features/curriculum/data/models/curriculum_campaign_model.dart';
import 'package:saas_mosque/features/curriculum/data/models/curriculum_model.dart';
import 'package:saas_mosque/features/curriculum/data/models/curriculum_node_model.dart';

class CurriculumTemplateModel {
  final int id;
  final int curriculumId;
  final int campaignId;
  final String name;
  final String notes;
  final String createdAt;
  final String updatedAt;
  final CurriculumModel curriculum;
  final CurriculumCampaignModel campaign;
  final List<CurriculumNodeModel> nodes;

  const CurriculumTemplateModel({
    required this.id,
    required this.curriculumId,
    required this.campaignId,
    required this.name,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.curriculum,
    required this.campaign,
    required this.nodes,
  });

  factory CurriculumTemplateModel.fromJson(Map<String, dynamic> json) {
    return CurriculumTemplateModel(
      id: json['id'] as int,
      curriculumId: json['curriculum_id'] as int,
      campaignId: json['campaign_id'] as int,
      name: json['name'] as String,
      notes: json['notes'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      curriculum: CurriculumModel.fromJson(
        json['curriculum'] as Map<String, dynamic>,
      ),
      campaign: CurriculumCampaignModel.fromJson(
        json['campaign'] as Map<String, dynamic>,
      ),
      nodes:
          (json['nodes'] as List<dynamic>)
              .map(
                (node) =>
                    CurriculumNodeModel.fromJson(node as Map<String, dynamic>),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'curriculum_id': curriculumId,
      'campaign_id': campaignId,
      'name': name,
      'notes': notes,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'curriculum': curriculum.toJson(),
      'campaign': campaign.toJson(),
      'nodes': nodes.map((node) => node.toJson()).toList(),
    };
  }
}
