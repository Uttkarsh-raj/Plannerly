import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plannerly/bloc/login/login_bloc.dart';
import 'package:plannerly/view/home/home.dart';
import 'package:plannerly/view/home/home_loading.dart';
import 'package:plannerly/view/signup/signup.dart';
import 'package:plannerly/view/widgets/form_field.dart';
import 'package:plannerly/utils/colors/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc = LoginBloc();
  TextEditingController userName = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  void dispose() {
    userName.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listenWhen: (previous, current) => current is LoginActionState,
      buildWhen: (previous, current) => current is! LoginActionState,
      listener: (context, state) {
        if (state is LoginSignupButtonClicked) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignUpPage(),
            ),
          );
        } else if (state is LoginSuccessState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else if (state is LoginShowSnackbar) {
          var snackBar = SnackBar(
            backgroundColor: Colors.red[500],
            content: Text(
              state.message,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoginLoadingState:
            return const HomeLoading();
          case LoginLoadingErrorState:
            var s = state as LoginLoadingErrorState;
            return Scaffold(
              backgroundColor: AppColors.backgroundDark,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.08),
                        const Center(
                          child: Text(
                            "Welcome to Plannerly !!",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            // "Let's get your things planned.",
                            "Planning Your Way to Productivity.",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/logo_transparent.png',
                          scale: 1.8,
                        ),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Column(
                            children: [
                              TaskFormField(
                                title: '',
                                hint: 'Email',
                                controller: userName,
                              ),
                              TaskFormField(
                                title: '',
                                hint: 'Password',
                                controller: pass,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 25,
                                color: Colors.red[400],
                              ),
                              const SizedBox(width: 5),
                              Center(
                                child: SizedBox(
                                  width: size.width * 0.7,
                                  child: Text(
                                    s.message,
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (userName.text.isNotEmpty &&
                                  pass.text.isNotEmpty) {
                                loginBloc.add(
                                  LoginButtonClickedEvent(
                                    userName: userName.text.trim().toString(),
                                    pass: pass.text.trim().toString(),
                                  ),
                                );
                              } else {
                                var snackBar = SnackBar(
                                  backgroundColor: Colors.red[500],
                                  content: const Text(
                                    "Please fill all the fields.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.white,
                                    ),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Container(
                              width: size.width * 0.7,
                              height: size.height * 0.07,
                              decoration: BoxDecoration(
                                color: AppColors.buttonBlue,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  loginBloc
                                      .add(LoginPageSignupButtonClickedEvent());
                                },
                                child: const Center(
                                  child: Text(
                                    "Sign-up",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColors.buttonBlue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          default:
            return Scaffold(
              backgroundColor: AppColors.backgroundDark,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.08),
                        const Center(
                          child: Text(
                            "Welcome to Plannerly !!",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            // "Let's get your things planned.",
                            "Planning Your Way to Productivity.",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/logo_transparent.png',
                          scale: 1.8,
                        ),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Column(
                            children: [
                              TaskFormField(
                                title: '',
                                hint: 'Email',
                                controller: userName,
                              ),
                              TaskFormField(
                                title: '',
                                hint: 'Password',
                                controller: pass,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (userName.text.isNotEmpty &&
                                  pass.text.isNotEmpty) {
                                loginBloc.add(
                                  LoginButtonClickedEvent(
                                    userName: userName.text.trim().toString(),
                                    pass: pass.text.trim().toString(),
                                  ),
                                );
                              } else {
                                var snackBar = SnackBar(
                                  backgroundColor: Colors.red[500],
                                  content: const Text(
                                    "Please fill all the fields.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.white,
                                    ),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Container(
                              width: size.width * 0.7,
                              height: size.height * 0.07,
                              decoration: BoxDecoration(
                                color: AppColors.buttonBlue,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  loginBloc
                                      .add(LoginPageSignupButtonClickedEvent());
                                },
                                child: const Center(
                                  child: Text(
                                    "Sign-up",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColors.buttonBlue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
