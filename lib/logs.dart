import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:travel_journal/models/log.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

import 'add.dart';
import 'log_details.dart';
import 'responsive_screen.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() {
    return _LogsScreenState();
  }
}

class _LogsScreenState extends State<LogsScreen> {
  List<JournalLog> logList = [];

  @override
  void initState() {
    super.initState();
    _fetchLogsFromDatabase();
  }

  Future<void> _fetchLogsFromDatabase() async { // Fetch logs from the database
    DatabaseReference logsRef = FirebaseDatabase.instance.ref('logs');
    DataSnapshot snapshot = await logsRef.get();

    if (snapshot.value == null) { // If there are no logs, return
      return;
    }

    final data = snapshot.value as Map<dynamic, dynamic>;
    setState(() {
      logList = data.values.map((json) => JournalLog.fromJson(json)).toList();
    });
  }

  void _addItem() async { // Add a new log
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

  void _viewLogDetails(JournalLog log) { // View log details
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => LogDetailsScreen(log: log),
      ),
    );
  }

  String _formatDate(DateTimeRange date) { // Format the date
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
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ResponsiveScreen(),
                ),
              );
            },
            child: const Text(
              'Responsive Screen',
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
                SizedBox(width: 8),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: logList.length,
              itemBuilder: (ctx, index) {
                final log = logList[index];
                return InkWell( // Added InkWell - a Material widget that makes its child interactive, so that the user can tap on it
                  onTap: () => _viewLogDetails(log),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(log.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Text(_formatDate(log.date), style: const TextStyle(color: Colors.grey)),
                                const SizedBox(height: 8),
                                Text(log.location, style: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic)),
                                const SizedBox(height: 8),
                                Text(log.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          if (log.images != null && log.images!.isNotEmpty) // If there are images, display the first image
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.width * 0.25,
                              margin: const EdgeInsets.only(left: 16.0),
                              child: Image.memory(base64Decode(log.images![0]), fit: BoxFit.cover),
                            ),
                        ],
                      ),
                    ),
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