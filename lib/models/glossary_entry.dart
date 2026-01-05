class GlossaryEntry {
  final String id;
  final String subject;
  final int grade;
  final String term;
  final String definition;

  const GlossaryEntry({
    required this.id,
    required this.subject,
    required this.grade,
    required this.term,
    required this.definition,
  });

  factory GlossaryEntry.fromJson(Map<String, dynamic> json) {
    return GlossaryEntry(
      id: json['id'] as String,
      subject: json['subject'] as String,
      grade: (json['grade'] as num).toInt(),
      term: json['term'] as String,
      definition: json['definition'] as String,
    );
  }
}
