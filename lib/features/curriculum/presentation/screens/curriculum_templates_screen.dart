import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/data/models/group_model.dart';
import 'package:saas_mosque/core/widget/custom_circular_progress_indicator.dart';
import 'package:saas_mosque/core/widget/custom_failur_screen.dart';
import 'package:saas_mosque/features/curriculum/presentation/bloc/curriculum_bloc.dart';
import 'package:saas_mosque/features/curriculum/presentation/screens/curriculum_details_screen.dart';
import 'package:saas_mosque/features/curriculum/presentation/widgets/curriculum_template_card.dart';

class CurriculumTemplatesScreen extends StatefulWidget {
  final GroupModel group;

  const CurriculumTemplatesScreen({super.key, required this.group});

  @override
  State<CurriculumTemplatesScreen> createState() =>
      _CurriculumTemplatesScreenState();
}

class _CurriculumTemplatesScreenState extends State<CurriculumTemplatesScreen> {
  @override
  void initState() {
    context.read<CurriculumBloc>().add(GetCurriculumTemplates(widget.group.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurriculumBloc, CurriculumState>(
      listener: (context, state) {
        if (state is CurriculumDetailsView) {
          final curriculumBloc = context.read<CurriculumBloc>();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BlocProvider<CurriculumBloc>.value(
                    value: curriculumBloc,
                    child: const CurriculumDetailsScreen(),
                  ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CurriculumLoading) {
          return const Center(child: CustomCircularProgressIndicator());
        }

        if (state is CurriculumFailure) {
          log("Curriculum Failure: ${state.message}");
          return FailureScreen(
            onPressed: () {
              context.read<CurriculumBloc>().add(
                GetCurriculumTemplates(widget.group.id),
              );
            },
          );
        }

        if (state is CurriculumTemplatesLoaded) {
          if (state.templates.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد مناهج متاحة',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: state.templates.length,
            itemBuilder: (context, index) {
              final template = state.templates[index];
              return CurriculumTemplateCard(
                template: template,
                onTap: () {
                  context.read<CurriculumBloc>().add(
                    SelectCurriculumTemplate(template),
                  );
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
