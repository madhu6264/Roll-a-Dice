import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roll_a_dice/features/auth/view/login_screen.dart';
import 'package:roll_a_dice/features/auth/view_model/auth_view_model.dart';
import 'package:roll_a_dice/features/home/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkUserLoggedin();
  }

  _checkUserLoggedin() async {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      AuthProvider authProvider = Provider.of(context, listen: false);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  authProvider.isAuthenticated ? HomeScreen() : LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/splash_bg.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.center)),
      ),
    );
  }
}
