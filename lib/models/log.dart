class JournalLog {
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final List<String>? images; // Optional array of base64 strings

  JournalLog({
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    this.images,
  });
}