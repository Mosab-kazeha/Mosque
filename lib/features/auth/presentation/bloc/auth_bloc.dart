import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/auth/data/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  final formKey = GlobalKey<FormState>();
  String phone = '', password = '';

  AuthBloc(AuthRepo authRepo) : _authRepo = authRepo, super(AuthInitial()) {
    on<LoginRequest>((event, emit) async {
      emit(AuthLoading());
      (await _authRepo.login(
        phone: phone,
        password: password,
      )).fold(
        (l) => emit(AuthFailure(l.errorMessege)),
        (r) => emit(AuthSuccess()),
      );
    });
  }
}
