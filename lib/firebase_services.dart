import 'package:firebase_storage/firebase_storage.dart';

Future<String?> getDownloadURL() async {
  try {
    return await FirebaseStorage.instance
        .ref('EXP4_CB.EN.U4EEE20013.pdf')
        .getDownloadURL();
  } catch (e) {
    print("An error occurred: $e");
    return null;
  }
}


  // You can add other Firebase-related methods here in the future.
