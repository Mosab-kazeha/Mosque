import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('\x1B[32monCreate -- ${bloc.runtimeType}.\x1B[0m');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('\x1B[32monChange -- ${bloc.runtimeType}, $change.\x1B[0m');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('\x1B[32monError -- ${bloc.runtimeType}, $error.\x1B[0m');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('\x1B[32monClose -- ${bloc.runtimeType}.\x1B[0m');
  }
}
