import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_saver/controllers/password.controller.dart';
import 'package:password_saver/widgets/views.widgets.dart';

class Password extends ConsumerStatefulWidget {
  const Password({super.key});

  @override
  ConsumerState<Password> createState() => _PasswordState();
}

class _PasswordState extends ConsumerState<Password> {
  final TextEditingController value = TextEditingController();
  final TextEditingController pin = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  int pinObscure = 1;
  int valueObscure = 1;
  @override
  Widget build(BuildContext context) {
    final passwordController = ref.watch(passwordControllerProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Your Passwords are\nsafe with us!',
                style: TextStyle(
                    fontFamily: 'Rajdhani-Light',
                    color: Colors.black,
                    fontSize: 34,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: title,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: UIViews.inputBorder(radius: 20),
                  disabledBorder: UIViews.inputBorder(radius: 20),
                  focusedBorder: UIViews.inputBorder(radius: 20),
                  hintText: 'Title',
                  hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                maxLines: 2,
                minLines: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: description,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: UIViews.inputBorder(radius: 20),
                  disabledBorder: UIViews.inputBorder(radius: 20),
                  focusedBorder: UIViews.inputBorder(radius: 20),
                  hintText: 'Description',
                  hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                maxLines: 5,
                minLines: 4,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: value,
                obscureText: valueObscure == 1 ? true : false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: UIViews.inputBorder(radius: 20),
                  disabledBorder: UIViews.inputBorder(radius: 20),
                  focusedBorder: UIViews.inputBorder(radius: 20),
                  hintText: 'Value',
                  suffixIcon: IconButton(
                    onPressed: () {
                      valueObscure = 1 - valueObscure;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  ),
                  hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                maxLines: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: pin,
                keyboardType: TextInputType.number,
                obscureText: pinObscure == 1 ? true : false,
                decoration: InputDecoration(
                  enabledBorder: UIViews.inputBorder(radius: 20),
                  disabledBorder: UIViews.inputBorder(radius: 20),
                  focusedBorder: UIViews.inputBorder(radius: 20),
                  hintText: 'Pin',
                  suffixIcon: IconButton(
                    onPressed: () {
                      pinObscure = 1 - pinObscure;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  ),
                  hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                maxLines: 1,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  passwordController.createPassword(
                      context: context,
                      title: title.text.toString(),
                      description: description.text.toString(),
                      value: value.text.toString(),
                      pin: pin.text.toString(),
                      ref: ref);
                },
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(400, 45)),
                  elevation: MaterialStateProperty.all<double>(1),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  )),
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
