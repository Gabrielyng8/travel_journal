import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  var _enteredTitle = '';
  DateTimeRange? _selectedDateRange;
  final List<String> _base64Images = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64String = base64Encode(imageBytes);

      setState(() {
        _base64Images.add(base64String);
      });
    }
  }

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
        title: _enteredTitle,
        description: _enteredJournalEntry,
        location: _enteredLocation,
        date: _selectedDateRange!,
        images: _base64Images,
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
    if (picked != null) {
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
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredTitle = value!;
                },
              ),
              const SizedBox(height: 16),
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
                      _selectedDateRange == null ? 'Duration' : '${DateFormat('dd/MM').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM').format(_selectedDateRange!.end)}',
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
                  _showImagePickerDialog();
                },
                child: const Text('Take / Upload Photos'),
              ),
              const SizedBox(height: 16),

              _base64Images.isNotEmpty
                  ? Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children:
                        _base64Images.map((base64String) {
                          return Stack(
                            children: [
                              Image.memory(
                                base64Decode(base64String),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ],
                          );
                        }).toList(),
                  )
                  : const Text("No images selected."),
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