import 'package:flutter/material.dart';
import 'package:travel_journal/models/log.dart';

final logList = [
  JournalLog(
    id: '1',
    title: 'First Log',
    description: 'This is the first log',
    //date is a DateTimeRange
    date: DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(days: 1)),
    ),
    location: 'New York',
  ),
  JournalLog(
    id: '2',
    title: 'Second Log',
    description: 'This is the second log',
    date: DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(days: 1)),
    ),
    location: 'Paris',
  ),
  JournalLog(
    id: '3',
    title: 'Third Log',
    description: 'This is the third log',
    date: DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(days: 1)),
    ),
    location: 'Tokyo',
  ),
];