import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_journal/models/log.dart';

class AddLogScreen extends StatefulWidget {
  const AddLogScreen({super.key});

  @override
  State<AddLogScreen> createState() {
    return _AddLogScreenState();
  }
}

class _AddLogScreenState extends State<AddLogScreen> {
  final _formKey = GlobalKey<FormState>();

  var _enteredLocation = '';
  var _enteredJournalEntry = '';
  DateTimeRange? _selectedDateRange;

  void _submitNewLog() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDateRange == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a date range')),
        );
        return;
      }
      _formKey.currentState!.save();

      var newLog = JournalLog(
        id: DateTime.now().toString(),
        title: _enteredLocation, // Assuming title is the location
        description: _enteredJournalEntry,
        location: _enteredLocation,
        date: _selectedDateRange!,
        images: [], // Placeholder for images
      );

      Navigator.of(context).pop(newLog);
    }
  }

  void _pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredLocation = value!;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDateRange == null
                          ? 'Duration'
                          : '${DateFormat('dd/MM').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM').format(_selectedDateRange!.end)}',
                      style: TextStyle(
                        color: _selectedDateRange == null ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _pickDateRange,
                    child: const Text('Select Date Range'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 8,
                decoration: const InputDecoration(
                  labelText: 'Journal Entry',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a journal entry';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredJournalEntry = value!;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle image upload
                },
                child: const Text('Take / Upload Photos'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _submitNewLog();
                    },
                    child: const Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}