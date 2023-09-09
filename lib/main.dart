import 'package:flutter/material.dart';
import 'package:chat_app/screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:chat_app/screens/folder_page.dart';
import 'package:chat_app/screens/year_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

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
        FolderPage.routeName: (ctx) => FolderPage(),
        // ... any other static routes
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case YearPage.routeName:
            final year = settings.arguments as String;
            return MaterialPageRoute(builder: (ctx) => YearPage(year: year));
          // Handle other dynamic routes here, if any
          default:
            return null;
        }
      },
    );
  }
}
