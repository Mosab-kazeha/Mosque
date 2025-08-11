import 'package:saas_mosque/features/campaigns/data/models/campaign_model.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';
import 'package:saas_mosque/features/room/features/listening/data/models/evaluation_model.dart';
import 'package:saas_mosque/features/room/features/listening/data/models/mistake_model.dart';
import 'package:saas_mosque/features/room/features/listening/data/models/teacher_model.dart';

class ListeningModel {
  final int id;
  final int teacherId;
  final int studentId;
  final int campaignId;
  final int evaluationId;
  final int start;
  final int end;
  final int rating;
  final int duration;
  final DateTime createdAt;
  final StudentModel student;
  final TeacherModel teacher;
  final CampaignModel campaign;
  final EvaluationModel evaluation;
  final List<MistakeModel> mistakes;

  ListeningModel({
    required this.id,
    required this.teacherId,
    required this.studentId,
    required this.campaignId,
    required this.evaluationId,
    required this.start,
    required this.end,
    required this.rating,
    required this.duration,
    required this.createdAt,
    required this.student,
    required this.teacher,
    required this.campaign,
    required this.evaluation,
    required this.mistakes,
  });

  factory ListeningModel.fromJson(Map<String, dynamic> json) {
    return ListeningModel(
        id: json['id'] ?? 0,
        teacherId: json['teacher_id'] ?? json['teacherId'] ?? 0,
        studentId: json['student_id'] ?? json['studentId'] ?? 0,
        campaignId: json['campaign_id'] ?? json['campaignId'] ?? 0,
        evaluationId: json['evaluation_id'] ?? json['evaluationId'] ?? 0,
        start: json['start'] ?? 0,
        end: json['end'] ?? 0,
        rating: json['rating'] ?? 0,
        duration: json['duration'] ?? 0,
        createdAt:
            DateTime.tryParse(json['created_at']?.toString() ?? '') ??
            DateTime.now(),
        student: StudentModel.fromJson(json['student'] ?? {}),
        teacher: TeacherModel.fromJson(json['teacher'] ?? {}),
        campaign: CampaignModel.fromJson(json['campaign'] ?? {}),
        evaluation: EvaluationModel.fromJson(json['evaluation'] ?? {}),
        mistakes:
            (json['mistakes_in_session'] as List<dynamic>? ??
                    json['mistakes'] as List<dynamic>? ??
                    [])
                .map((e) {
                  // mistakes_in_session has nested 'mistake' object
                  if (e is Map && e.containsKey('mistake')) {
                    return MistakeModel(
                      id: e['id'] ?? 0,
                      page: e['page'] ?? 0,
                      title: (e['mistake']?['title'] ?? '').toString(),
                    );
                  } else {
                    return MistakeModel(
                      id: e['id'] ?? 0,
                      page: e['page'] ?? 0,
                      title: (e['title'] ?? '').toString(),
                    );
                  }
                })
                .toList(),
      );
  }
}
