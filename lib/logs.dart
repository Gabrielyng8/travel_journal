import 'package:flutter/material.dart';
import 'package:travel_journal/data/dummy_logs.dart';
import 'package:travel_journal/models/log.dart';

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
      logList.add(newLog!);
    });
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
          // Placeholder for the list of logs
          Center(child: Text('Your travel logs will appear here')),
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
