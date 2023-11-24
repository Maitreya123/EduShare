import 'package:flutter/material.dart';
import '../course.dart'; // Import Course class
import '../course_page.dart'; // Import CoursePage widget
import '../course_data.dart'; // Import getCoursesByYearAndSemester function

class SemesterPage extends StatelessWidget {
  final String year;
  final String semester;

  SemesterPage({required this.year, required this.semester}) {
    print("SemesterPage initialized with year: $year, semester: $semester");
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the list of courses for the selected year and semester
    List<Course> courses = getCoursesByYearAndSemester(year, semester);
    print("Loaded courses: ${courses.map((c) => c.name).join(", ")}");

    return Scaffold(
      appBar: AppBar(title: Text('$year - $semester')),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          Course course = courses[index];
          return ElevatedButton(
            onPressed: () {
              // Navigate to CoursePage with the selected course
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => CoursePage(course: course)),
              );
            },
            child: Text(course.name),
          );
        },
      ),
    );
  }
}
