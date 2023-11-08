part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignUpButtonClickedEvent extends SignupEvent {
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final String pass;

  SignUpButtonClickedEvent(
      {required this.fname,
      required this.lname,
      required this.email,
      required this.phone,
      required this.pass});
}

class SignupPageLoginButtonClickedEvent extends SignupEvent {}
