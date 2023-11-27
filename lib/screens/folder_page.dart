import 'package:flutter/material.dart';
import 'year_page.dart';
import 'chatpage.dart';
import 'chatgptfile.dart';

class FolderPage extends StatelessWidget {
  static const routeName = '/folder-page';
  final String userEmail; // property to hold the user's email
  FolderPage({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Year')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 20, 149, 254),
              Color.fromARGB(255, 194, 163, 199),
              Color.fromARGB(255, 214, 118, 118),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
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
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => chatpage(email: userEmail),
                ),
              );
            },
            child: Text('Open Chat'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatGPTFile(),
            ),
          );
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: Icon(Icons.navigation),
        label: Text("ChatGPT"),
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
          arguments: title,
        );
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
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
