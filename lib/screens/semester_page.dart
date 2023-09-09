// semester_page.dart
import 'package:flutter/material.dart';

class SemesterPage extends StatelessWidget {
  final String year;
  final String semester;

  SemesterPage({required this.year, required this.semester});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$year - $semester')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate to Course A page
            },
            child: Text('Course A'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to Course B page
            },
            child: Text('Course B'),
          ),
        ],
      ),
    );
  }
}
