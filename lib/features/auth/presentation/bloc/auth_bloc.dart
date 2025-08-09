import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/auth/data/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  AuthBloc(AuthRepo authRepo) : _authRepo = authRepo, super(AuthInitial()) {
    on<LoginRequest>((event, emit) async {
      emit(AuthLoading());
      (await _authRepo.login(
        phone: event.phone,
        password: event.password,
      )).fold(
        (l) => emit(AuthFailure(l.errorMessege)),
        (r) => emit(AuthSuccess()),
      );
    });
  }
}
