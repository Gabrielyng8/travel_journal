import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting
import 'package:travel_journal/data/dummy_logs.dart';
import 'package:travel_journal/models/log.dart';
import 'dart:convert';
import 'dart:io';

import 'add.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() {
    return _LogsScreenState();
  }
}

class _LogsScreenState extends State<LogsScreen> {
  void _addItem() async {
    var newLog = await Navigator.of(context).push<JournalLog>(
      MaterialPageRoute(
        builder: (ctx) => const AddLogScreen(),
      ),
    );

    setState(() {
      // Add the new log to the list of logs
      if (newLog != null) {
        logList.add(newLog);
      }
    });
  }

  String _formatDate(DateTimeRange date) {
    // If date start is older than a year, show the year
    if (DateTime.now().difference(date.start).inDays > 365) {
      return '${DateFormat.yMMMd().format(date.start)} - ${DateFormat.yMMMd().format(date.end)}';
    } else {
      return '${DateFormat.MMMd().format(date.start)} - ${DateFormat.MMMd().format(date.end)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Travel Journal',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 30),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.account_circle_outlined, size: 30),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ), // Added horizontal padding
            child: Row(
              children: [
                Text('Your logs', style: TextStyle(fontSize: 20)),
                SizedBox(width: 8),
                Icon(Icons.location_on_outlined),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: logList.length,
              itemBuilder: (ctx, index) {
                final log = logList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(log.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_formatDate(log.date), style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 8),
                        Text(log.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    trailing: log.images != null && log.images!.isNotEmpty
                      ? Image.memory(base64Decode(log.images![0]), width: 100, height: 100)
                      : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItem();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}