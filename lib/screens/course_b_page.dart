import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../firebase_services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CourseAPage extends StatefulWidget {
  @override
  _CourseAPageState createState() => _CourseAPageState();
}

class _CourseAPageState extends State<CourseAPage> {
  String? _localPath;

  Future<void> uploadFile() async {
    await _requestPermission();

    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      final String fileName = file.path.split('/').last;
      final Reference storageRef =
          FirebaseStorage.instance.ref('course_b/$fileName');
      await storageRef.putFile(file);
    }
  }

  Future<void> downloadAndOpenFile(String fileName) async {
    await _requestPermission();

    final Reference storageRef =
        FirebaseStorage.instance.ref('course_b/$fileName');

    final String url = await storageRef.getDownloadURL();

    final http.Response response = await http.get(Uri.parse(url));

    Directory? downloadsDirectory = await getDownloadsDirectory();

    final String filePath = '${downloadsDirectory?.path ?? ''}/$fileName';

    File file = File(filePath);

    await file.writeAsBytes(response.bodyBytes);

    setState(() {
      _localPath = file.path;
    });
  }

  Future<List<String>> listFilesInStorage() async {
    final Reference storageRef = FirebaseStorage.instance.ref('course_a/');
    final ListResult result = await storageRef.list();

    return result.items.map((item) => item.name).toList();
  }

  Future<void> _requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception("Storage permission not granted");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course B')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: uploadFile,
              child: Text('Upload File'),
            ),
            FutureBuilder<List<String>>(
              future: listFilesInStorage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final fileNames = snapshot.data ?? [];
                  return Expanded(
                    child: ListView.builder(
                      itemCount: fileNames.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(fileNames[index]),
                          onTap: () => downloadAndOpenFile(fileNames[index]),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            if (_localPath != null)
              Expanded(
                child: PDFView(
                  filePath: _localPath,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
