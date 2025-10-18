import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/widget/custom_app_bar.dart';
import 'package:saas_mosque/core/widget/custom_circular_progress_indicator.dart';
import 'package:saas_mosque/features/curriculum/presentation/bloc/curriculum_bloc.dart';
import 'package:saas_mosque/features/curriculum/presentation/widgets/curriculum_expansion_card.dart';
import 'package:saas_mosque/features/curriculum/presentation/widgets/lesson_notes_bottom_sheet.dart';
import 'package:saas_mosque/features/curriculum/presentation/widgets/today_lesson_hero_section.dart';
import 'package:saas_mosque/features/curriculum/data/models/curriculum_node_model.dart';

class CurriculumDetailsScreen extends StatelessWidget {
  const CurriculumDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      appBar: const CustomAppBar(title: 'المنهج'),
      body: BlocConsumer<CurriculumBloc, CurriculumState>(
        listener: (context, state) {
          if (state is CurriculumFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is LessonSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إرسال الدرس بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LessonSubmitting) {
            return const Center(child: CustomCircularProgressIndicator());
          }

          if (state is CurriculumDetailsView || state is LessonStarted) {
            final template =
                state is CurriculumDetailsView
                    ? state.template
                    : (state as LessonStarted).template;
            final todayLesson =
                state is CurriculumDetailsView
                    ? state.todayLesson
                    : (state as LessonStarted).todayLesson;
            final isLessonStarted = state is LessonStarted;
            final startedNode = state is LessonStarted ? state.node : null;

            return Column(
              children: [
                TodayLessonHeroSection(
                  todayLesson: todayLesson,
                  isLessonStarted: isLessonStarted,
                  onStartLesson:
                      todayLesson != null
                          ? () {
                            context.read<CurriculumBloc>().add(
                              StartLesson(todayLesson),
                            );
                          }
                          : null,
                  onCancel: () {
                    context.read<CurriculumBloc>().add(const CancelLesson());
                  },
                  onFinish: () {
                    if (startedNode != null) {
                      _showNotesBottomSheet(context, startedNode.id);
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'جميع الدروس',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.backgroundColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                      template.nodes.isEmpty
                          ? const Center(
                            child: Text(
                              'لا توجد دروس في هذا المنهج',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                          : _buildExpansionCards(
                            template.nodes,
                            startedNode?.id,
                          ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildExpansionCards(
    List<CurriculumNodeModel> allNodes,
    int? currentNodeId,
  ) {
    // Get only the root nodes (nodes with no parent)
    final rootNodes =
        allNodes.where((node) => node.parentId == null).toList()
          ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: rootNodes.length,
      itemBuilder: (context, index) {
        final node = rootNodes[index];
        return CurriculumExpansionCard(
          node: node,
          allNodes: allNodes,
          currentNodeId: currentNodeId,
          onNodeTap: () {
            // Handle node tap if needed
            // You can add navigation or other actions here
          },
        );
      },
    );
  }

  void _showNotesBottomSheet(BuildContext context, int nodeId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return LessonNotesBottomSheet(
          onSubmit: (sessionData) {
            log('Submitting lesson $nodeId with data: ${sessionData.notes}');
            context.read<CurriculumBloc>().add(
              FinishLesson(
                nodeId: nodeId,
                notes: sessionData.notes,
                sessionNumber: sessionData.sessionNumber,
                durationMinutes: sessionData.durationMinutes,
                isFinished: sessionData.isFinished,
              ),
            );
          },
        );
      },
    );
  }
}
