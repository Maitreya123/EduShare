import 'package:flutter/material.dart';
import 'package:chat_app/screens/semester_page.dart';
// year_page.dart

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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SemesterPage(year: year, semester: 'Semester 1')));
              },
              child: Text('Semester 1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SemesterPage(year: year, semester: 'Semester 2')));
              },
              child: Text('Semester 2'),
            ),
          ],
        ),
      ),
    );
  }
}
