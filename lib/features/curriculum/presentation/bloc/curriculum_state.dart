part of 'curriculum_bloc.dart';

@immutable
sealed class CurriculumState {
  const CurriculumState();
}

final class CurriculumInitial extends CurriculumState {}

final class CurriculumLoading extends CurriculumState {}

final class CurriculumTemplatesLoaded extends CurriculumState {
  final List<CurriculumTemplateModel> templates;

  const CurriculumTemplatesLoaded(this.templates);
}

final class CurriculumDetailsView extends CurriculumState {
  final CurriculumTemplateModel template;
  final CurriculumNodeModel? todayLesson;

  const CurriculumDetailsView(this.template, this.todayLesson);
}

final class LessonStarted extends CurriculumState {
  final CurriculumTemplateModel template;
  final CurriculumNodeModel node;
  final CurriculumNodeModel? todayLesson;

  const LessonStarted(this.template, this.node, this.todayLesson);
}

final class LessonSubmitting extends CurriculumState {}

final class LessonSubmitted extends CurriculumState {
  final CurriculumTemplateModel template;

  const LessonSubmitted(this.template);
}

final class CurriculumFailure extends CurriculumState {
  final String message;

  const CurriculumFailure(this.message);
}
