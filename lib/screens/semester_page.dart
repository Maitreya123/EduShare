import 'package:flutter/material.dart';
import '../course.dart';
import '../course_page.dart';
import '../course_data.dart';

class SemesterPage extends StatelessWidget {
  final String year;
  final String semester;

  SemesterPage({required this.year, required this.semester}) {
    print("SemesterPage initialized with year: $year, semester: $semester");
  }

  @override
  Widget build(BuildContext context) {
    List<Course> courses = getCoursesByYearAndSemester(year, semester);
    print("Loaded courses: ${courses.map((c) => c.name).join(", ")}");

    return Scaffold(
      appBar: AppBar(title: Text('$year - $semester')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            Course course = courses[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => CoursePage(course: course)),
                  );
                },
                title: Text(course.name,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Click to view more details'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            );
          },
        ),
      ),
    );
  }
}
