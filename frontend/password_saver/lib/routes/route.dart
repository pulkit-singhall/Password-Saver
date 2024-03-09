import 'package:flutter/material.dart';
import 'package:password_saver/screens/dashboard.screen.dart';
import 'package:password_saver/screens/login.screen.dart';
import 'package:password_saver/screens/password.screen.dart';
import 'package:password_saver/screens/register.screen.dart';

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

  static MaterialPageRoute dashboardRoute() {
    return MaterialPageRoute(builder: (builder) {
      return const Dashboard();
    });
  }

  static MaterialPageRoute passwordRoute() {
    return MaterialPageRoute(builder: (builder) {
      return const Password();
    });
  }
}
