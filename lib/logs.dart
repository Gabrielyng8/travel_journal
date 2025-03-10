import 'package:flutter/material.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() {
    return _LogsScreenState();
  }
}

class _LogsScreenState extends State<LogsScreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Text(
                'Your logs',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.location_on_outlined),
            ],
          ),
        ),
        // Placeholder for the list of logs
        Center(
          child: Text('Your travel logs will appear here'),
        ),
      ],
    );
  }
}
