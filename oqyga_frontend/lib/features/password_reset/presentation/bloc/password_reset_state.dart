part of 'password_reset_bloc.dart';

enum PasswordResetStatus {
  initial, // Ввод номера телефона
  loading,
  otpSent, // Ввод ОТП
  otpValidated, // Ввод нового пароля
  success, // Успешное завершение
  failure,
}

class PasswordResetState extends Equatable {
  final PasswordResetStatus status;
  final String phoneNumber; // Храним для отображения в UI
  final String resetToken; // Храним для отправки на последнем шаге
  final String errorMessage;

  const PasswordResetState({
    this.status = PasswordResetStatus.initial,
    this.phoneNumber = '',
    this.resetToken = '',
    this.errorMessage = '',
  });

  PasswordResetState copyWith({
    PasswordResetStatus? status,
    String? phoneNumber,
    String? resetToken,
    String? errorMessage,
  }) {
    return PasswordResetState(
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      resetToken: resetToken ?? this.resetToken,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, phoneNumber, resetToken, errorMessage];
}
