// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

abstract class SignupActionState extends SignupState {}

final class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupLoadedSuccess extends SignupState {}

class SignupLoadedError extends SignupState {}

class SignupButtonClicked extends SignupActionState {}

class SignupPageLoginButtonClicked extends SignupActionState {}

class SignupPageError extends SignupActionState {
  String errorMessage;
  SignupPageError({
    required this.errorMessage,
  });
}
