import 'package:dartz/dartz.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/features/curriculum/data/models/curriculum_template_model.dart';

class CreateLessonSessionRequest {
  final int nodeId;
  final int groupId;
  final int teacherId;
  final int campaignId;
  final int sessionNumber;
  final String date;
  final bool isFinished;
  final int durationMinutes;
  final String notes;
  final bool isLate;

  CreateLessonSessionRequest({
    required this.nodeId,
    required this.groupId,
    required this.teacherId,
    required this.campaignId,
    required this.sessionNumber,
    required this.date,
    required this.isFinished,
    required this.durationMinutes,
    required this.notes,
    required this.isLate,
  });

  Map<String, dynamic> toJson() {
    return {
      'node_id': nodeId,
      'group_id': groupId,
      'teacher_id': teacherId,
      'campaign_id': campaignId,
      'session_number': sessionNumber,
      'date': date,
      'is_finished': isFinished,
      'duration_minutes': durationMinutes,
      'notes': notes,
      'is_late': isLate,
    };
  }
}

abstract class CurriculumRepo {
  Future<Either<Failure, List<CurriculumTemplateModel>>> getCurriculumTemplates(
    int groupId,
  );
  Future<Either<Failure, void>> createLessonSession(
    CreateLessonSessionRequest request,
  );
  Future<Either<Failure, void>> startLessonSession(int nodeId);
}
