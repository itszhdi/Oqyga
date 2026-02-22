import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqyga_frontend/core/router/routes.dart';
import 'package:oqyga_frontend/features/auth/data/utils/validators.dart';
import 'package:oqyga_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        SignUpRequested(
          name: _nameController.text.trim(),
          password: _passwordController.text.trim(),
          phone: _phoneController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/static/logo oqiga!.png', height: 56),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: s.phoneLabel,
                    hintText: s.phoneHint,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // Передаем объект 's' в валидатор
                  validator: (value) => AppValidators.validatePhone(value, s),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: s.usernameLabel,
                    border: const OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // Используем 's' для получения сообщения об ошибке
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      // Можно также использовать s.emptyError(s.usernameLabel.toLowerCase())
                      // для более динамичного сообщения, как в SignInView
                      return s.usernameEmpty;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: s.passwordLabel,
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // Передаем объект 's' в валидатор
                  validator: (value) =>
                      AppValidators.validatePassword(value, s),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: s.confirmPasswordLabel,
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return s.confirmPasswordEmpty;
                    }
                    if (val != _passwordController.text) {
                      return s.passwordsDoNotMatchError;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state.status == AuthStatus.loading;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _register,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(s.signUpButton),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => context.go(Routes.signInPage),
                  child: Text(
                    s.alreadyHaveAccountLink,
                    style: const TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
