import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/features/auth/presentation/bloc/auth_bloc.dart';

class LoginButtonnn extends StatelessWidget {
  const LoginButtonnn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<AuthBloc>(context);

        if (state is AuthLoading) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppPalette.backgroundColor,
              ),
            ),
          );
        }
        return ElevatedButton(
          onPressed: () {
            bloc.add(
              LoginRequest(
                bloc.phoneController.text,
                bloc.passwordController.text,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPalette.white,
            foregroundColor: AppPalette.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Text(
            "تسجيل الدخول",
            style: TextStyle(
              color: AppPalette.backgroundColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
            textDirection: TextDirection.rtl,
          ),
        );
      },
    );
  }
}
