import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/core/router/routes.dart';
import 'package:oqyga_frontend/features/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:oqyga_frontend/features/password_reset/presentation/views/forgot_password_view.dart';
import 'package:oqyga_frontend/features/password_reset/presentation/views/new_password_view.dart';
import 'package:oqyga_frontend/features/password_reset/presentation/views/validate_otp_view.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/themes/pallete.dart';

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocProvider(
      create: (_) => sl<PasswordResetBloc>(),
      child: BlocListener<PasswordResetBloc, PasswordResetState>(
        listener: (context, state) {
          if (state.status == PasswordResetStatus.failure) {
            final errorMessage = translateErrorMessage(
              context,
              state.errorMessage,
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(errorMessage),
                  backgroundColor: AppPallete.borderColor,
                ),
              );
          }
          if (state.status == PasswordResetStatus.success) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(s.passwordResetSuccess),
                  backgroundColor: Colors.green,
                ),
              );
            context.go(Routes.signInPage);
          }
        },
        child: BlocBuilder<PasswordResetBloc, PasswordResetState>(
          builder: (context, state) {
            switch (state.status) {
              case PasswordResetStatus.initial:
              case PasswordResetStatus.failure:
                return const ForgotPasswordView();
              case PasswordResetStatus.loading:
                return const _LoadingScaffold();
              case PasswordResetStatus.otpSent:
                return ValidateOtpView(phoneNumber: state.phoneNumber);
              case PasswordResetStatus.otpValidated:
                return const NewPasswordView();
              case PasswordResetStatus.success:
                return const Scaffold(body: Center(child: Text('')));
            }
          },
        ),
      ),
    );
  }
}

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
