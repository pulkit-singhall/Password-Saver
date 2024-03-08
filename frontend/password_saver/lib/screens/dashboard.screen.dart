import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_saver/controllers/user.controller.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final userController = ref.watch(userControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            userController.getCurrentUser(ref: ref, context: context);
          },
          icon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.person_3,
              color: Colors.black,
              size: 35,
            ),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text('$index'),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // new password action here
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
