import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../firebase_services.dart'; // Adjust based on your project structure
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'course.dart'; // Adjust based on your project structure

class CoursePage extends StatefulWidget {
  final Course course;

  CoursePage({Key? key, required this.course}) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String? _localPath;

  Future<void> uploadFile() async {
    await _requestPermission();

    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      final String fileName = file.path.split('/').last;
      final Reference storageRef = FirebaseStorage.instance
          .ref('${widget.course.firebaseFolder}/$fileName');
      await storageRef.putFile(file);
    }
  }

  Future<void> downloadAndOpenFile(String fileName) async {
    await _requestPermission();

    final Reference storageRef = FirebaseStorage.instance
        .ref('${widget.course.firebaseFolder}/$fileName');

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
    final Reference storageRef =
        FirebaseStorage.instance.ref('${widget.course.firebaseFolder}/');
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
      appBar: AppBar(
        title: Text(widget.course.name),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildUploadButton(),
              _buildFilesList(),
              _buildPdfViewer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return ElevatedButton(
      onPressed: uploadFile,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Button color
        onPrimary: Colors.white, // Text color
      ),
      child: const Text('Upload File'),
    );
  }

  Widget _buildFilesList() {
    return FutureBuilder<List<String>>(
      future: listFilesInStorage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final fileNames = snapshot.data ?? [];
          return Expanded(
            child: ListView.builder(
              itemCount: fileNames.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/pdf.PNG',
                      width: 24.0, // Adjust the width as needed
                      height: 24.0, // Adjust the height as needed
                    ),
                    title: Text(fileNames[index]),
                    onTap: () => downloadAndOpenFile(fileNames[index]),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildPdfViewer() {
    return _localPath == null
        ? Container()
        : Expanded(
            child: PDFView(
              filePath: _localPath,
            ),
          );
  }
}
