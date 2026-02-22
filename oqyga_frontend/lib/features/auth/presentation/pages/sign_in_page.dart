import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:oqyga_frontend/features/auth/presentation/views/sign_in_view.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocProvider.value(
      value: GetIt.I<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.error) {
            final messageKey = state.errorMessage;
            final translatedMessage = translateErrorMessage(
              context,
              messageKey,
            );

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(s.signInError(translatedMessage))),
              );
          }
          if (state.status == AuthStatus.authenticated) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(s.signInSuccess)));
          }
        },
        child: const SignInView(),
      ),
    );
  }
}
