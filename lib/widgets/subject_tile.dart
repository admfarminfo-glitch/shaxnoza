import 'package:flutter/material.dart';

class SubjectTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SubjectTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
