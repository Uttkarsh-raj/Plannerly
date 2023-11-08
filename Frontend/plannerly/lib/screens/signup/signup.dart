import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plannerly/bloc/signup/signup_bloc.dart';
import 'package:plannerly/screens/home/home_loading.dart';
import 'package:plannerly/screens/login/login.dart';
import 'package:plannerly/screens/widgets/form_field.dart';
import 'package:plannerly/utils/colors/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignupBloc signUpBloc = SignupBloc();
  TextEditingController fuserName = TextEditingController();
  TextEditingController luserName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  void dispose() {
    fuserName.dispose();
    luserName.dispose();
    email.dispose();
    phone.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<SignupBloc, SignupState>(
      bloc: signUpBloc,
      listenWhen: (previous, current) => current is SignupActionState,
      buildWhen: (previous, current) => current is! SignupActionState,
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          var snackBar = SnackBar(
            backgroundColor: Colors.green[400],
            content: const Text(
              "Account created! Please log in to continue.",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is SignupPageLoginButtonClicked) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        } else if (state is SignupShowSnackbar) {
          var snackBar = SnackBar(
            backgroundColor: Colors.red[500],
            content: Text(
              state.errorMessage,
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
          case SignupLoading:
            return const HomeLoading();
          default:
            return Scaffold(
              backgroundColor: AppColors.backgroundDark,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: size.height * 0.12),
                        Image.asset(
                          'assets/images/logo_transparent.png',
                          scale: 3.2,
                        ),
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
                        SizedBox(
                          width: size.width * 0.8,
                          child: Column(
                            children: [
                              TaskFormField(
                                title: '',
                                hint: 'First-name',
                                controller: fuserName,
                              ),
                              TaskFormField(
                                title: '',
                                hint: 'Last-name',
                                controller: luserName,
                              ),
                              TaskFormField(
                                title: '',
                                hint: 'Phone',
                                controller: phone,
                              ),
                              TaskFormField(
                                title: '',
                                hint: 'Email',
                                controller: email,
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
                              if (fuserName.text.isNotEmpty &&
                                  luserName.text.isNotEmpty &&
                                  email.text.isNotEmpty &&
                                  pass.text.isNotEmpty &&
                                  phone.text.isNotEmpty) {
                                signUpBloc.add(
                                  SignUpButtonClickedEvent(
                                    fname: fuserName.text.trim().toString(),
                                    lname: luserName.text.trim().toString(),
                                    email: email.text.trim().toString(),
                                    phone: phone.text.trim().toString(),
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
                                  "Sign-Up",
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
                                "Already have an account?",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  signUpBloc
                                      .add(SignupPageLoginButtonClickedEvent());
                                },
                                child: const Center(
                                  child: Text(
                                    "Login",
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
