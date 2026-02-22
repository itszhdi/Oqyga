import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/features/password_reset/domain/usecases/request_otp.dart';
import 'package:oqyga_frontend/features/password_reset/domain/usecases/reset_password.dart';
import 'package:oqyga_frontend/features/password_reset/domain/usecases/validate_otp.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  final RequestOtp _requestOtp;
  final ValidateOtp _validateOtp;
  final ResetPassword _resetPassword;

  PasswordResetBloc({
    required RequestOtp requestOtp,
    required ValidateOtp validateOtp,
    required ResetPassword resetPassword,
  }) : _requestOtp = requestOtp,
       _validateOtp = validateOtp,
       _resetPassword = resetPassword,
       super(const PasswordResetState()) {
    on<OtpRequested>(_onOtpRequested);
    on<OtpValidated>(_onOtpValidated);
    on<NewPasswordSubmitted>(_onNewPasswordSubmitted);
  }

  Future<void> _onOtpRequested(
    OtpRequested event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(state.copyWith(status: PasswordResetStatus.loading));
    final result = await _requestOtp(event.phoneNumber);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PasswordResetStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: PasswordResetStatus.otpSent,
          phoneNumber: event.phoneNumber,
        ),
      ),
    );
  }

  Future<void> _onOtpValidated(
    OtpValidated event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(state.copyWith(status: PasswordResetStatus.loading));
    final result = await _validateOtp(event.otp);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PasswordResetStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (resetToken) => emit(
        state.copyWith(
          status: PasswordResetStatus.otpValidated,
          resetToken: resetToken,
        ),
      ),
    );
  }

  Future<void> _onNewPasswordSubmitted(
    NewPasswordSubmitted event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(state.copyWith(status: PasswordResetStatus.loading));
    final result = await _resetPassword(
      resetToken: state.resetToken,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PasswordResetStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: PasswordResetStatus.success)),
    );
  }
}
