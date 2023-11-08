part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {
  final String userName;
  final String pass;

  LoginButtonClickedEvent({required this.userName, required this.pass});
}

class LoginPageSignupButtonClickedEvent extends LoginEvent {}
