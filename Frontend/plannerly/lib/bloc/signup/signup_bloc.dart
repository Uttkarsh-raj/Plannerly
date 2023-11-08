import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:plannerly/utils/server/server_constants.dart';
import 'package:http/http.dart' as http;
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
    on<SignupPageLoginButtonClickedEvent>(signupPageLoginButtonClickedEvent);
  }

  FutureOr<void> signUpButtonClickedEvent(
      SignUpButtonClickedEvent event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    var uri = Uri.parse("$baseUrl/user/signup");
    try {
      var res = await http.post(
        uri,
        body: jsonEncode(
          {
            "first_name": event.fname.toString(),
            "last_name": event.lname.toString(),
            "email": event.email.toString(),
            "password": event.pass.toString(),
            "phone": event.phone.toString(),
          },
        ),
      );
      var response = jsonDecode(res.body);
      if (res.statusCode == 200) {
        emit(SignUpSuccessState());
      } else {
        emit(SignupShowSnackbar(errorMessage: response['error']));
      }
    } catch (e) {
      emit(SignupShowSnackbar(errorMessage: e.toString()));
      print(e.toString());
    }
  }

  FutureOr<void> signupPageLoginButtonClickedEvent(
      SignupPageLoginButtonClickedEvent event, Emitter<SignupState> emit) {
    emit(SignupPageLoginButtonClicked());
  }
}
