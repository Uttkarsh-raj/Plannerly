import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:plannerly/utils/server/server_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<LoginPageSignupButtonClickedEvent>(loginPageSignupButtonClickedEvent);
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    var url = Uri.parse("$baseUrl/user/login");
    try {
      var res = await http.post(
        url,
        body: jsonEncode(
          {
            "email": event.userName.toString(),
            "password": event.pass.toString(),
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var response = jsonDecode(res.body);
      if (res.statusCode == 200) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('token', response['token']);
        sp.setString('userId', response['user_id']);
        sp.setString(
            'userName', response['first_name'] + " " + response['last_name']);
        emit(LoginSuccessState());
      } else {
        emit(LoginShowSnackbar(message: response['error']));
      }
    } catch (e) {
      emit(LoginShowSnackbar(message: e.toString()));
    }
  }

  FutureOr<void> loginPageSignupButtonClickedEvent(
      LoginPageSignupButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginSignupButtonClicked());
    print("Signup button clicked");
    emit(LoginSignupButtonClicked());
  }
}
