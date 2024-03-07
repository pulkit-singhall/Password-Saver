import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_saver/controllers/user.controller.dart';
import 'package:password_saver/widgets/views.widgets.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  int isObscure = 1;

  @override
  Widget build(BuildContext context) {
    final userController = ref.watch(userControllerProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              const Text(
                "Welcome Back!",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    fontFamily: 'Rajdhani-Light',
                    fontStyle: FontStyle.normal),
              ),
              const SizedBox(
                height: 160,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "Email",
                      hintMaxLines: 1,
                      focusedBorder: UIViews.inputBorder(radius: 15),
                      disabledBorder: UIViews.inputBorder(radius: 15),
                      enabledBorder: UIViews.inputBorder(radius: 15),
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 67, 66, 66),
                          fontSize: 16)),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: TextField(
                  controller: password,
                  obscureText: isObscure == 1 ? true : false,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          isObscure = 1 - isObscure;
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.remove_red_eye_sharp,
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Password",
                      hintMaxLines: 1,
                      focusedBorder: UIViews.inputBorder(radius: 15),
                      disabledBorder: UIViews.inputBorder(radius: 15),
                      enabledBorder: UIViews.inputBorder(radius: 15),
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 67, 66, 66),
                          fontSize: 16)),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 370,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          // login action
                          userController.loginUser(
                              password: password.text.toString(),
                              email: email.text.toString(),
                              context: context,
                              ref: ref);
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(50, 45)),
                          elevation: MaterialStateProperty.all<double>(0),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          )),
                        ),
                        child: const Text(
                          "Proceed",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "New user?",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Register Here",
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
