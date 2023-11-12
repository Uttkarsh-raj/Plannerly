part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

abstract class LoginActionState extends LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadingErrorState extends LoginState {
  final String message;

  LoginLoadingErrorState({required this.message});
}

class LoginShowSnackbar extends LoginActionState {
  final String message;
  LoginShowSnackbar({required this.message});
}

class LoginSignupButtonClicked extends LoginActionState {}

class LoginSuccessState extends LoginActionState {}
