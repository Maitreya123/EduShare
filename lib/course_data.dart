import '../course.dart'; // Ensure this import points to where your Course class is defined

List<Course> getCoursesByYearAndSemester(String year, String semester) {
  var courses = <Course>[];

  if (year == '1' && semester == '1') {
    courses = [
      Course(
          name: 'Course A',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseA'),
      Course(
          name: 'Course B',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseB'),

      // Add more courses as needed
    ];
  } else if (year == '1' && semester == '2') {
    courses = [
      Course(
          name: 'Course C',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseC'),
      Course(
          name: 'Course D',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseD'),
      // Add more courses as needed
    ];
    // Add more conditions for other years and semesters
  } else if (year == '2' && semester == '1') {
    courses = [
      Course(
          name: 'Course E',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseC'),
      Course(
          name: 'Course F',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseD'),
      // Add more courses as needed
    ];
    // Add more conditions for other years and semesters
  } else if (year == '2' && semester == '2') {
    courses = [
      Course(
          name: 'Course G',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseC'),
      Course(
          name: 'Course H',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseD'),
      // Add more courses as needed
    ];
    // Add more conditions for other years and semesters
  } else if (year == '3' && semester == '1') {
    courses = [
      Course(
          name: 'Course I',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseC'),
      Course(
          name: 'Course J',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseD'),
      // Add more courses as needed
    ];
    // Add more conditions for other years and semesters
  } else if (year == '3' && semester == '2') {
    courses = [
      Course(
          name: 'Course K',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseC'),
      Course(
          name: 'Course L',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseD'),
      // Add more courses as needed
    ];
    // Add more conditions for other years and semesters
  } else if (year == '4' && semester == '1') {
    courses = [
      Course(
          name: 'Course M',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseC'),
      Course(
          name: 'Course N',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseD'),
      // Add more courses as needed
    ];
    // Add more conditions for other years and semesters
  } else if (year == '4' && semester == '2') {
    courses = [
      Course(
          name: 'Course O',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseC'),
      Course(
          name: 'Course P',
          year: year,
          semester: semester,
          firebaseFolder: 'year${year}_sem${semester}_courseD'),
      // Add more courses as needed
    ];
    // Add more conditions for other years and semesters
  }

  return courses;
}
