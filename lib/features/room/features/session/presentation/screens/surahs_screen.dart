import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/custom_app_bar.dart';
import 'package:saas_mosque/core/widget/custom_circular_progress_indicator.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';
import 'package:saas_mosque/features/room/features/session/presentation/bloc/session_bloc.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/surah_list_item.dart';

class SurahsScreen extends StatefulWidget {
  final StudentModel student;
  const SurahsScreen({super.key, required this.student});

  @override
  State<SurahsScreen> createState() => _SurahsScreenState();
}

class _SurahsScreenState extends State<SurahsScreen> {
  @override
  void initState() {
    context.read<SessionBloc>()
      ..add(FetchSurahs())
      ..setSelectedStudent(widget.student);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: 'سور القرآن الكريم'),
        body: BlocBuilder<SessionBloc, SessionState>(
          builder: (context, state) {
            if (state is SessionLoading) {
              return const Center(child: CustomCircularProgressIndicator());
            }
            if (state is SessionFailure) {
              return Center(
                child: ResponsiveText(
                  state.message,
                  fontSize: FontTextSize.defaultFontSize,
                ),
              );
            }
            if (state is FetchSurahsSuccess) {
              // final surahs = state.getSurahs();

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: state.surahs.length,
                itemBuilder: (context, index) {
                  return SurahListItem(surah: state.surahs[index]);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
