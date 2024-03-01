import 'package:flutter/material.dart';
import 'package:password_saver/core/views.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  int isObscure = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              const Text(
                "Protect what protects\nyour data!",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
              const SizedBox(
                height: 120,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: TextField(
                  controller: fullname,
                  decoration: InputDecoration(
                      hintText: "Full Name",
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
                          // register action
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
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already a user?",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Login Here",
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
