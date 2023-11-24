import 'package:flutter/material.dart';
import 'package:chat_app/screens/semester_page.dart';
// year_page.dart
import '../course.dart'; // Import Course class
import '../course_page.dart'; // Import CoursePage widget
import '../course_data.dart';

class YearPage extends StatelessWidget {
  static const routeName = '/year-page';

  final String year;

  YearPage({required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(year)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Extract just the numeric part of the year string
                String numericYear = year.replaceAll(RegExp(r'[^0-9]'), '');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SemesterPage(year: numericYear, semester: '1'),
                  ),
                );
              },
              child: Text('Semester 1'),
            ),
            ElevatedButton(
              onPressed: () {
                String numericYear = year.replaceAll(RegExp(r'[^0-9]'), '');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SemesterPage(year: numericYear, semester: '2'),
                  ),
                );
              },
              child: Text('Semester 2'),
            ),
          ],
        ),
      ),
    );
  }
}
