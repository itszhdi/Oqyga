part of 'password_reset_bloc.dart';

abstract class PasswordResetEvent extends Equatable {
  const PasswordResetEvent();

  @override
  List<Object> get props => [];
}

class OtpRequested extends PasswordResetEvent {
  final String phoneNumber;
  const OtpRequested(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class OtpValidated extends PasswordResetEvent {
  final String otp;
  const OtpValidated(this.otp);

  @override
  List<Object> get props => [otp];
}

class NewPasswordSubmitted extends PasswordResetEvent {
  final String newPassword;
  final String confirmPassword;

  const NewPasswordSubmitted(this.newPassword, this.confirmPassword);

  @override
  List<Object> get props => [newPassword, confirmPassword];
}
