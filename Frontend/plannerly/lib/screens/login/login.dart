import 'package:flutter/material.dart';
import 'package:plannerly/screens/widgets/form_field.dart';
import 'package:plannerly/utils/colors/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController userName = TextEditingController();
    TextEditingController pass = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      hint: 'Username',
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
                  onTap: () {},
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
                      onPressed: () {},
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
    );
  }
}
