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
              Navigator.of(context).pushNamed(
                  'course_a'); // Navigate to Course A page using the string 'course_a'
            },
            child: Text('Course A'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                  'course_b'); // Navigate to Course B page using the string 'course_b'
            },
            child: Text('Course B'),
          ),
        ],
      ),
    );
  }
}
