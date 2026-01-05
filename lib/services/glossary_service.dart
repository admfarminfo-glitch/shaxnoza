import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/glossary_entry.dart';

class GlossaryService {
  Future<List<GlossaryEntry>> loadEntries() async {
    final raw = await rootBundle.loadString('assets/glossary.json');
    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((entry) => GlossaryEntry.fromJson(entry as Map<String, dynamic>))
        .toList();
  }
}
