import 'package:flutter/material.dart';
import 'package:chat_app/screens/year_page.dart';

class FolderPage extends StatelessWidget {
  static const routeName = '/folder-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Year')),
      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Displaying 2 tiles side by side
          childAspectRatio:
              3 / 2, // Adjusting aspect ratio for better appearance
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          YearTile('Year 1'),
          YearTile('Year 2'),
          YearTile('Year 3'),
          YearTile('Year 4'),
        ],
      ),
    );
  }
}

class YearTile extends StatelessWidget {
  final String title;
  YearTile(this.title);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          YearPage.routeName,
          arguments: title, // 'Year 1', 'Year 2', etc.
        );
        // Here, you'll navigate to the specific year page when it's created.
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
    );
  }
}
