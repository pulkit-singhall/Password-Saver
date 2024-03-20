import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_saver/controllers/password.controller.dart';
//import 'package:password_saver/controllers/user.controller.dart';
import 'package:password_saver/routes/route.dart';
import 'package:password_saver/widgets/password_card.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    //final userController = ref.watch(userControllerProvider.notifier);
    final passwordController = ref.watch(passwordControllerProvider.notifier);
    final userPasswords =
        passwordController.getUserPasswords(ref: ref, context: context);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.menu_rounded,
                color: Colors.black,
                size: 30,
              ),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Rajdhani-Light',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 40),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: FutureBuilder(
          future: userPasswords,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final passwords = snapshot.data;
              if (passwords?.isEmpty == true) {
                return const Center(
                  child: Text(
                    'Create your first password',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: passwords?.length,
                  itemBuilder: (context, index) {
                    final currentPassword = passwords![index];
                    return PasswordCard(password: currentPassword);
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 3,
                color: Colors.blue.shade300,
              ),
            );
          },
        ),
      ),
      drawer: Drawer(
        elevation: 2,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/lock.png',
                    height: 120,
                    width: 120,
                    alignment: Alignment.center,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  child: const Text(
                    'Profile',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(context, Routes.proffileRoute());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // new password action here
          Navigator.push(context, Routes.passwordRoute());
        },
        elevation: 4,
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }
}
