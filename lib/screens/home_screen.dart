import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/subject_tile.dart';
import 'grade_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<String> _subjects = [
    'Kimyo',
    'Fizika',
    'Biologiya',
    'Ona tili',
    'Adabiyot',
    'Informatika',
  ];

  Future<void> _logout(BuildContext context) async {
    await AuthService().logout();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fanlar'),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _subjects.length,
        itemBuilder: (context, index) {
          final subject = _subjects[index];
          return SubjectTile(
            title: subject,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GradeScreen(subject: subject),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
