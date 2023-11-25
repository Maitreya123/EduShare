import 'package:flutter/material.dart';
import 'package:chat_app/screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:chat_app/screens/folder_page.dart';
import 'package:chat_app/screens/year_page.dart';
import '../course.dart'; // Import Course class
import '../course_page.dart'; // Import CoursePage widget
import '../course_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: const AuthScreen(),
      routes: {
        FolderPage.routeName: (ctx) {
          final args =
              ModalRoute.of(ctx)?.settings.arguments as Map<String, dynamic>;
          final userEmail = args['userEmail'];
          return FolderPage(userEmail: userEmail);
        },
        // Other named routes if necessary
      },
      onGenerateRoute: (settings) {
        if (settings.name == YearPage.routeName) {
          final year = settings.arguments as String;
          return MaterialPageRoute(builder: (ctx) => YearPage(year: year));
        }
        // No else if block for CoursePage.routeName

        // Handle other dynamic routes here, if any
        return null;
      },
    );
  }
}
