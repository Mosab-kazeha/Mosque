part of 'curriculum_bloc.dart';

@immutable
sealed class CurriculumEvent {
  const CurriculumEvent();
}

final class GetCurriculumTemplates extends CurriculumEvent {
  final int groupId;

  const GetCurriculumTemplates(this.groupId);
}

final class SelectCurriculumTemplate extends CurriculumEvent {
  final CurriculumTemplateModel template;

  const SelectCurriculumTemplate(this.template);
}

final class StartLesson extends CurriculumEvent {
  final CurriculumNodeModel node;

  const StartLesson(this.node);
}

final class CancelLesson extends CurriculumEvent {
  const CancelLesson();
}

final class FinishLesson extends CurriculumEvent {
  final int nodeId;
  final String notes;
  final int sessionNumber;
  final int durationMinutes;
  final bool isFinished;

  const FinishLesson({
    required this.nodeId,
    required this.notes,
    required this.sessionNumber,
    required this.durationMinutes,
    required this.isFinished,
  });
}
