part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginRequest extends AuthEvent {
  final String phone;
  final String password;

  LoginRequest(this.phone, this.password);
}
