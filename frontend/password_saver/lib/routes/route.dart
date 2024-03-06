import 'package:flutter/material.dart';
import 'package:password_saver/screens/login.dart';
import 'package:password_saver/screens/register.dart';

class Routes {
  static MaterialPageRoute registerRoute() {
    return MaterialPageRoute(builder: (builder) {
      return const Register();
    });
  }

  static MaterialPageRoute loginRoute() {
    return MaterialPageRoute(builder: (builder) {
      return const Login();
    });
  }
}
