import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:travel_journal/models/log.dart';

class LogDetailsScreen extends StatelessWidget {
  final JournalLog log;

  const LogDetailsScreen({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(log.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('${DateFormat.yMMMd().format(log.date.start)} - ${DateFormat.yMMMd().format(log.date.end)}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Text(log.description),
            const SizedBox(height: 16),
            log.images != null && log.images!.isNotEmpty
                ? Column(
                    children: log.images!.map((image) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.memory(base64Decode(image)),
                        ),
                      );
                    }).toList(),
                  )
                : const Text('No images available'),
          ],
        ),
      ),
    );
  }
}
