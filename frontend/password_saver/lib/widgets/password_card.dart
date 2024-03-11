import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_saver/controllers/password.controller.dart';

class PasswordCard extends ConsumerStatefulWidget {
  final dynamic password;
  const PasswordCard({super.key, required this.password});

  @override
  ConsumerState<PasswordCard> createState() => _PasswordCardState();
}

class _PasswordCardState extends ConsumerState<PasswordCard> {
  @override
  Widget build(BuildContext context) {
    final passwordController = ref.watch(passwordControllerProvider.notifier);
    final title = widget.password['title'];
    final description = widget.password['description'];
    final date = widget.password['createdAt'];
    final id = widget.password['_id'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.blueGrey, style: BorderStyle.solid, width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      '$title',
                      style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ),
                  const Spacer(),
                  DropdownButton(
                    items: [
                      DropdownMenuItem(
                          enabled: false,
                          child: TextButton(
                              onPressed: () {
                                // delete password
                                passwordController.deletePassword(
                                    passwordID: id, ref: ref, context: context);
                              },
                              child: const Text('Delete'))),
                      DropdownMenuItem(
                          enabled: false,
                          child: TextButton(
                              onPressed: () {
                                // update password
                              },
                              child: const Text('Update'))),
                    ],
                    onChanged: (value) {},
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    elevation: 0,
                  ),
                ],
              ),
              Text(
                '$description',
                style: const TextStyle(
                    fontSize: 20, overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
              Row(
                children: [
                  Text(
                    'Created At:',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                    '$date',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
