
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor/core/view/auth_view.dart';
import 'package:vendor/ui/auth/forgot_password_screen/forgot_password_screen.dart';
import 'package:vendor/ui/auth/login_screen/login_screen.dart';
import 'package:vendor/ui/main/main_screen.dart';
import 'package:vendor/ui/splash/splash_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

    if (authView.authState == AuthState.landing) {
      return const SplashScreen();
    } else {
      if (authView.authState == AuthState.signIn) {
        return const LoginScreen();
      }  else if (authView.authState == AuthState.forgot) {
        return const ForgotPasswordScreen();
      } else {
        return const MainScreen();
      }
    }
  }
}
