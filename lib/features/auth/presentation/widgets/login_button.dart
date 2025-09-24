import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/utils/size_config.dart';
import 'package:saas_mosque/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../core/widget/custom_circular_progress_indicator.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<AuthBloc>(context);

        if (state is AuthLoading) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(6),
            width: double.infinity,
            height: SizeConfig.height * 0.065,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppPalette.grey.withAlpha(120),
            ),
            child: const CustomCircularProgressIndicator(
              color: AppPalette.white,
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
            minimumSize: Size(SizeConfig.width, SizeConfig.height * 0.065),
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
