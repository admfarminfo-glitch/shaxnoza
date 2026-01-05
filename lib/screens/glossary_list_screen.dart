import 'package:flutter/material.dart';

import '../models/glossary_entry.dart';
import '../services/glossary_service.dart';
import 'term_detail_screen.dart';

class GlossaryListScreen extends StatefulWidget {
  final String subject;
  final int grade;

  const GlossaryListScreen({
    super.key,
    required this.subject,
    required this.grade,
  });

  @override
  State<GlossaryListScreen> createState() => _GlossaryListScreenState();
}

class _GlossaryListScreenState extends State<GlossaryListScreen> {
  final _searchController = TextEditingController();
  final _service = GlossaryService();
  late Future<List<GlossaryEntry>> _entriesFuture;

  @override
  void initState() {
    super.initState();
    _entriesFuture = _service.loadEntries();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<GlossaryEntry> _applyFilters(List<GlossaryEntry> entries) {
    final query = _searchController.text.trim().toLowerCase();
    return entries.where((entry) {
      final matchesSubject = entry.subject == widget.subject;
      final matchesGrade = entry.grade == widget.grade;
      final matchesQuery = query.isEmpty || entry.term.toLowerCase().contains(query);
      return matchesSubject && matchesGrade && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} · ${widget.grade}-sinf'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Atama bo\'yicha qidirish',
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<GlossaryEntry>>(
                future: _entriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Ma\'lumot yuklanmadi.'));
                  }
                  final entries = _applyFilters(snapshot.data ?? []);
                  if (entries.isEmpty) {
                    return const Center(child: Text('Mos atamalar topilmadi.'));
                  }
                  return ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return Card(
                        child: ListTile(
                          title: Text(entry.term),
                          subtitle: Text(
                            entry.definition,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => TermDetailScreen(entry: entry),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
