import 'package:flutter/material.dart';

class JournalLog {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTimeRange date;
  final List<String>? images; // Optional array of base64 strings

  JournalLog({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    this.images,
  });
}