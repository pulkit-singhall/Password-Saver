import 'package:flutter/material.dart';

class PasswordCard extends StatefulWidget {
  final dynamic password;
  const PasswordCard({super.key, required this.password});

  @override
  State<PasswordCard> createState() => _PasswordCardState();
}

class _PasswordCardState extends State<PasswordCard> {
  @override
  Widget build(BuildContext context) {
    final title = widget.password['title'];
    final description = widget.password['description'];
    final date = widget.password['createdAt'];
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
