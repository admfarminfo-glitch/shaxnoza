import 'package:flutter/material.dart';

import 'glossary_list_screen.dart';

class GradeScreen extends StatelessWidget {
  final String subject;

  const GradeScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final grades = List<int>.generate(7, (index) => 5 + index);

    return Scaffold(
      appBar: AppBar(title: Text(subject)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: grades.length,
        itemBuilder: (context, index) {
          final grade = grades[index];
          return Card(
            child: ListTile(
              title: Text('$grade-sinf'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => GlossaryListScreen(
                      subject: subject,
                      grade: grade,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
