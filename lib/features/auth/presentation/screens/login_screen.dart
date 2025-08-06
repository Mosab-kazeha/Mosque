import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/widget/custom_snack_bar.dart';
import 'package:saas_mosque/core/widget/custom_text_field.dart';
import 'package:saas_mosque/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:saas_mosque/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:saas_mosque/features/auth/presentation/widgets/login_buttonnn.dart';
import 'package:saas_mosque/features/auth/presentation/widgets/logo_hedar.dart';
import '../../../../core/style/app_palette.dart';
import '../../../../core/widget/spaces.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: AppPalette.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                CustomSnackBar.show(context, "تم تسجيل الدخول بنجاح");
              } else if (state is AuthFailure) {
                CustomSnackBar.show(
                  context,
                  "فشل في تسجيل الدخول",
                  type: SnackBarType.error,
                );
              }
            },
            child: Form(
              key: bloc.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoHeader(),
                  const VerticalSpace(48),
                  AuthTextField(
                    label: 'رقم الموبايل',
                    type: TextFieldType.phone,
                    hintText: 'رقم الموبايل',
                    onChanged: (p0) => bloc.phone = p0,
                  ),
                  const VerticalSpace(16),
                  AuthTextField(
                    label: 'كلمة المرور',
                    type: TextFieldType.password,
                    hintText: '**********',
                    onChanged: (p0) => bloc.password = p0,
                  ),
                  const VerticalSpace(40),
                  LoginButtonnn(),
                  // LoginButton(
                  //   onPressed: () {
                  //     if (bloc.formKey.currentState!.validate()) {}
                  //   },
                  //   isLoading: false,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
