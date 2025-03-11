import 'package:flutter/material.dart';

class JournalLog {
  final String title;
  final String description;
  final String location;
  final DateTimeRange date;
  final List<String>? images; // Optional array of base64 strings

  JournalLog({
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    this.images,
  });

  factory JournalLog.fromJson(Map<dynamic, dynamic> json) {
    return JournalLog(
      title: json['title'],
      description: json['description'],
      location: json['location'],
      date: DateTimeRange(
        start: DateTime.parse(json['date']['start']),
        end: DateTime.parse(json['date']['end']),
      ),
      images: json['images'] != null ? List<String>.from(json['images']) : null,
    );
  }
}