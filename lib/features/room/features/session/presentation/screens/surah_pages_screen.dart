import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/custom_app_bar.dart';
import 'package:saas_mosque/core/widget/custom_circular_progress_indicator.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/features/session/data/models/surah_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/surah_template_model.dart';
import 'package:saas_mosque/features/room/features/session/presentation/bloc/session_bloc.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/start_session_button.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/surah_page_grid_item.dart';

class SurahPagesScreen extends StatefulWidget {
  final SurahModel surah;
  const SurahPagesScreen({super.key, required this.surah});

  @override
  State<SurahPagesScreen> createState() => _SurahPagesScreenState();
}

class _SurahPagesScreenState extends State<SurahPagesScreen> {
  @override
  void initState() {
    context.read<SessionBloc>().add(FetchSurahTemplates(widget.surah.number));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            _onPopInvoked();
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'سورة ${widget.surah.name}',
            leading: IconButton(
              onPressed: () {
                _onPopInvoked();
                context.pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
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
              if (state is FetchSurahTemplatesSuccess) {
                if (state.surahTemplates.length == 1) {
                  return _OnePageSurah(state.surahTemplates.first);
                }
                return _MultiPagesSurah(state.surahTemplates);
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  void _onPopInvoked() {
    final bloc = context.read<SessionBloc>();
    bloc.selectedPages.clear();
    bloc.add(FetchSurahs());
    // context.pop();
  }
}

class _OnePageSurah extends StatefulWidget {
  final SurahTemplateModel surahTemlate;
  const _OnePageSurah(this.surahTemlate);

  @override
  State<_OnePageSurah> createState() => _OnePageSurahState();
}

class _OnePageSurahState extends State<_OnePageSurah> {
  @override
  void initState() {
    final bloc = context.read<SessionBloc>();
    bloc.selectedPages.add(widget.surahTemlate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppPalette.grey),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ResponsiveText(
              'سورة قصيرة',
              fontSize: FontTextSize.bodyFontSize,
              fontWeight: FontWeight.bold,
            ),
            VerticalSpace(4),
            ResponsiveText(
              'هذه السورة تحتوي على صفحة واحدة فقط',
              fontSize: FontTextSize.defaultFontSize,
              color: AppPalette.grey,
            ),
            VerticalSpace(8),
            StartSessionButton(),
          ],
        ),
      ),
    );
  }
}

class _MultiPagesSurah extends StatelessWidget {
  final List<SurahTemplateModel> surahTemplates;
  const _MultiPagesSurah(this.surahTemplates);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: surahTemplates.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // mainAxisExtent: 100,
              childAspectRatio: 3 / 1.6,
            ),
            itemBuilder:
                (context, index) =>
                    SurahPageGridItem(surahTemplate: surahTemplates[index]),
          ),
        ),
        const StartSessionButton(),
      ],
    );
  }
}
