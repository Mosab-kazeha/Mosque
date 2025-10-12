import 'package:saas_mosque/features/room/features/session/data/models/mistake_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/surah_template_model.dart';

final class SubmitSessionModel {
  final int teacherId;
  final int studentId;
  final int campaignId;
  final int evaluationId;
  final int startPage;
  final int endPage;
  final int rating;
  final int durationSeconds;
  final int totalScore;
  final int maxPossibleScore;
  // final bool overallPassed;
  final List<SessionSurahModel> sessionSurahs;

  const SubmitSessionModel({
    required this.teacherId,
    required this.studentId,
    required this.campaignId,
    required this.evaluationId,
    required this.startPage,
    required this.endPage,
    required this.rating,
    required this.durationSeconds,
    required this.totalScore,
    required this.maxPossibleScore,
    // required this.overallPassed,
    required this.sessionSurahs,
  });

  Map<String, dynamic> get sessionData {
    return {
      "teacherId": teacherId,
      "studentId": studentId,
      "campaign_id": campaignId,
      "evaluation_id": evaluationId,
      "start": startPage,
      "end": endPage,
      "rating": rating,
      "duration": durationSeconds,
      "totalScore": totalScore,
      "maxPossibleScore": maxPossibleScore,
      // "overallPassed": overallPassed,
      "sessionSurahs": sessionSurahs.map((e) => e.sessionSurahData).toList(),
    };
  }
}

final class SessionSurahModel {
  final SurahTemplateModel template;
  final int evaluationId;
  final bool isPassed;
  final double score;
  final double rawScore;
  final double weightedScore;
  final bool isCompleted;
  final String notes;
  final List<MistakeModel> mistakes;

  const SessionSurahModel({
    required this.template,
    required this.evaluationId,
    required this.isPassed,
    required this.score,
    required this.rawScore,
    required this.weightedScore,
    required this.isCompleted,
    required this.notes,
    required this.mistakes,
  });

  Map<String, dynamic> get sessionSurahData {
    return {
      "templateId": template.id,
      "evaluationId": evaluationId,
      "isPassed": isPassed,
      "score": score,
      "rawScore": rawScore,
      "weightedScore": weightedScore,
      "isCompleted": isCompleted,
      "notes": notes,
      "mistakes": mistakes.map((e) => {"mistakeId": e.id}).toList(),
    };
  }
}

// final class SubmitSessionModel {
//   final int teacherId;
//   final int studentId;
//   final int campaignId;
//   final int evaluationId;
//   final int startPage;
//   final int endPage;
//   final double rating;
//   final int duration;
//   final double totalScore;
//   final int maxPossibleScore;
//   final bool sessionSurahs;

//   const SubmitSessionModel({
//     required this.teacherId,
//     required this.studentId,
//     required this.campaignId,
//     required this.evaluationId,
//     required this.startPage,
//     required this.endPage,
//     required this.rating,
//     required this.duration,
//     required this.totalScore,
//     required this.maxPossibleScore,
//     required this.sessionSurahs,
//   });

//   Map<String, dynamic> get sessionData {
//     return {
//       "teacherId": teacherId,
//       "studentId": studentId,
//       "campaign_id": campaignId,
//       "evaluation_id": evaluationId,
//       "start": startPage,
//       "end": endPage,
//       "rating": rating,
//       "duration": duration,
//       "totalScore": totalScore,
//       "maxPossibleScore": maxPossibleScore,
//       "sessionSurahs": sessionSurahs,
//     };
//   }
// }
