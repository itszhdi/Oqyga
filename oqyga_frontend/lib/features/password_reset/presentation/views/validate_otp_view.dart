import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqyga_frontend/core/router/routes.dart';
import 'package:oqyga_frontend/features/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/views/widgets/shadowed_button.dart';

class ValidateOtpView extends StatefulWidget {
  final String phoneNumber;
  const ValidateOtpView({super.key, required this.phoneNumber});

  @override
  State<ValidateOtpView> createState() => _ValidateOtpViewState();
}

class _ValidateOtpViewState extends State<ValidateOtpView> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _validateOtp() {
    if (_formKey.currentState!.validate()) {
      context.read<PasswordResetBloc>().add(
        OtpValidated(_otpController.text.trim()),
      );
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isLoading = context.select(
      (PasswordResetBloc bloc) =>
          bloc.state.status == PasswordResetStatus.loading,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  ShadowedBackButton(
                    onPressed: () => context.go(Routes.forgotPassword),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    s.resetPasswordTitle,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Text(
                          s.otpSentDescription(widget.phoneNumber),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _otpController,
                        decoration: InputDecoration(labelText: s.otpLabel),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        validator: (value) =>
                            (value?.isEmpty ?? true) ? s.enterOtpError : null,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: isLoading ? null : _validateOtp,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(s.confirmButton),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
