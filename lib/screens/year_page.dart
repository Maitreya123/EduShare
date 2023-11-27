import 'package:flutter/material.dart';
import 'package:chat_app/screens/semester_page.dart';

class YearPage extends StatelessWidget {
  static const routeName = '/year-page';
  final String year;

  YearPage({required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(year, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: BoxDecoration(
          // A more elaborate gradient
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade300,
              Colors.purple.shade300,
              Colors.red.shade300,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSemesterButton(context, '1'),
                SizedBox(height: 20),
                _buildSemesterButton(context, '2'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSemesterButton(BuildContext context, String semester) {
    String numericYear = year.replaceAll(RegExp(r'[^0-9]'), '');

    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                SemesterPage(year: numericYear, semester: semester),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.indigo, // Button color
        onPrimary: Colors.white, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 10, // Added elevation for depth
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      ),
      child: Text(
        'Semester $semester',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
