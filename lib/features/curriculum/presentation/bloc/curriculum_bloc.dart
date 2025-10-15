import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/curriculum/data/models/curriculum_node_model.dart';
import 'package:saas_mosque/features/curriculum/data/models/curriculum_template_model.dart';
import 'package:saas_mosque/features/curriculum/data/repositories/curriculum_repo.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'curriculum_event.dart';
part 'curriculum_state.dart';

class CurriculumBloc extends Bloc<CurriculumEvent, CurriculumState> {
  final CurriculumRepo _curriculumRepo;

  CurriculumBloc(CurriculumRepo curriculumRepo)
    : _curriculumRepo = curriculumRepo,
      super(CurriculumInitial()) {
    on<GetCurriculumTemplates>((event, emit) async {
      emit(CurriculumLoading());
      (await _curriculumRepo.getCurriculumTemplates(event.groupId)).fold(
        (l) => emit(CurriculumFailure(l.errorMessege)),
        (r) => emit(CurriculumTemplatesLoaded(r)),
      );
    });

    on<SelectCurriculumTemplate>((event, emit) {
      final todayLesson = _findTodayLesson(event.template.nodes);
      emit(CurriculumDetailsView(event.template, todayLesson));
    });

    on<StartLesson>((event, emit) async {
      if (state is CurriculumDetailsView) {
        final currentState = state as CurriculumDetailsView;

        // Call the placeholder API
        final result = await _curriculumRepo.startLessonSession(event.node.id);

        result.fold(
          (failure) => emit(CurriculumFailure(failure.errorMessege)),
          (_) => emit(
            LessonStarted(
              currentState.template,
              event.node,
              currentState.todayLesson,
            ),
          ),
        );
      }
    });

    on<CancelLesson>((event, emit) {
      if (state is LessonStarted) {
        final currentState = state as LessonStarted;
        emit(
          CurriculumDetailsView(
            currentState.template,
            currentState.todayLesson,
          ),
        );
      }
    });

    on<FinishLesson>((event, emit) async {
      if (state is LessonStarted) {
        final currentState = state as LessonStarted;
        emit(LessonSubmitting());

        // Get required IDs from SharedPreferences and template
        final prefs = serviceLocater.get<SharedPreferences>();
        final groupId = prefs.getInt('group-id') ?? 0;
        final teacherIdString = prefs.getString('teacher-id') ?? '0';
        final teacherId = int.tryParse(teacherIdString) ?? 0;
        // Get campaign ID from template, fallback to SharedPreferences if needed
        final campaignId =
            currentState.template.campaignId != 0
                ? currentState.template.campaignId
                : prefs.getInt('campaign-id') ?? 0;

        log('Creating lesson session with IDs:');
        log('Group ID: $groupId');
        log('Teacher ID String: $teacherIdString');
        log('Teacher ID: $teacherId');
        log('Campaign ID: $campaignId');

        final request = CreateLessonSessionRequest(
          nodeId: event.nodeId,
          groupId: groupId,
          teacherId: teacherId,
          campaignId: campaignId,
          sessionNumber: event.sessionNumber,
          date: DateTime.now().toIso8601String(),
          isFinished: event.isFinished,
          durationMinutes: event.durationMinutes,
          notes: event.notes,
          isLate: false, // Auto-calculated as false
        );

        (await _curriculumRepo.createLessonSession(request)).fold(
          (l) => emit(CurriculumFailure(l.errorMessege)),
          (r) {
            // After successful submission, go back to details view
            final todayLesson = _findTodayLesson(currentState.template.nodes);
            emit(LessonSubmitted(currentState.template));
            emit(CurriculumDetailsView(currentState.template, todayLesson));
          },
        );
      }
    });
  }

  CurriculumNodeModel? _findTodayLesson(List<CurriculumNodeModel> nodes) {
    // First, try to find the last node with status "IN_PROGRESS"
    CurriculumNodeModel? inProgressNode;
    for (var node in nodes.reversed) {
      if (node.status == 'IN_PROGRESS') {
        inProgressNode = node;
        break;
      }
    }

    if (inProgressNode != null) {
      return inProgressNode;
    }

    // If no IN_PROGRESS node found, find the first node with status "PLANNED"
    for (var node in nodes) {
      if (node.status == 'PLANNED') {
        return node;
      }
    }

    return null;
  }
}
