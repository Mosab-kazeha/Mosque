import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/features/session/presentation/bloc/session_bloc.dart';

class SessionTimer extends StatelessWidget {
  const SessionTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      buildWhen: (previous, current) => current is EndPageSuccess,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppPalette.backgroundColor,
            border: Border.all(color: AppPalette.white, width: 4),
          ),
          child: Column(
            children: [
              const _Time(),
              const VerticalSpace(8),
              ResponsiveText(
                'الصفحة ${context.read<SessionBloc>().sessionCurrentPage}',
                // 'الصفحة ${_sessionCurrentPage(context)}',
                fontSize: FontTextSize.bodyFontSize,
                color: AppPalette.white,
              ),
            ],
          ),
        );
      },
    );
  }

  // int _sessionCurrentPage(BuildContext context) {
  //   final bloc = context.read<SessionBloc>();

  //   if (bloc.sessionCurrentPage == null) {
  //     return 0;
  //     // return int.parse(bloc.startPageController.text);
  //   }
  //   return bloc.sessionCurrentPage!;
  // }
}

class _Time extends StatefulWidget {
  const _Time();

  @override
  State<_Time> createState() => _TimeState();
}

class _TimeState extends State<_Time> {
  late final Timer _timer;
  int _seconds = 0;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds = _seconds + 1;
        context.read<SessionBloc>().sessionDurationSeconds = _seconds;
      });
    });
  }

  String get _formattedTime {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveText(
      _formattedTime,
      fontSize: FontTextSize.bigFontSize,
      fontWeight: FontWeight.bold,
      color: AppPalette.white,
    );
  }
}
