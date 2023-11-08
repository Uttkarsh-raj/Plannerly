import 'package:flutter/material.dart';
import 'package:plannerly/screens/home/home.dart';
import 'package:plannerly/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainAuth extends StatefulWidget {
  const MainAuth({super.key});

  @override
  State<MainAuth> createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
  bool login = false;
  void check() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    if (token != "") {
      setState(() {
        login = true;
      });
    }
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (login) ? const HomeScreen() : const LoginPage();
  }
}
