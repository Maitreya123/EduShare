import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CourseBPage extends StatefulWidget {
  @override
  _CourseBPageState createState() => _CourseBPageState();
}

class _CourseBPageState extends State<CourseBPage> {
  File? _selectedFile;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No file selected.')));
    }
  }

  Future<void> uploadFile() async {
    if (_selectedFile == null) return;
    try {
      await FirebaseStorage.instance
          .ref('course_b/')
          .child(_selectedFile!.path.split('/').last)
          .putFile(_selectedFile!);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('File uploaded successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to upload file.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course B')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickFile,
              child: Text('Pick File'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadFile,
              child: Text('Upload File'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement the download logic here
              },
              child: Text('Download File'),
            ),
            // Display the selected file name (if any)
            if (_selectedFile != null) ...[
              SizedBox(height: 20),
              Text('Selected File: ${_selectedFile!.path.split('/').last}'),
            ]
          ],
        ),
      ),
    );
  }
}
