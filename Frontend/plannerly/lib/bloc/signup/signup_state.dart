part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

abstract class SignupActionState extends SignupState {}

final class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupLoadedSuccess extends SignupState {}

class SignupLoadedError extends SignupState {
  final String message;

  SignupLoadedError({required this.message});
}

class SignupButtonClicked extends SignupActionState {}

class SignupPageLoginButtonClicked extends SignupActionState {}

class SignupShowSnackbar extends SignupActionState {
  final String errorMessage;
  SignupShowSnackbar({
    required this.errorMessage,
  });
}

class SignUpSuccessState extends SignupActionState {}
