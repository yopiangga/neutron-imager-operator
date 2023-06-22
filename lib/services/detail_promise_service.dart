import 'dart:html';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/promise_model.dart';

class DetailPromiseService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  final List<String> stroke = [
    'Normal',
    'Stroke Ischemic',
    'Stroke Hemorrhagic',
  ];

  Future<Map<String, dynamic>> getUser() async {
    try {
      User? user = auth.currentUser;
      DocumentSnapshot snapshot =
          await firestore.collection('user').doc(user!.uid).get();

      return snapshot.data() as Map<String, dynamic>;
    } catch (e) {
      print("ERROR: $e");
      return {};
    }
  }

  Future<bool> uploadImage(Promise promise) async {
    final uploadInput = FileUploadInputElement();
    String link = "";
    File file;

    uploadInput.click();

    await uploadInput.onChange.listen((event) {
      file = uploadInput.files!.first;
      final reader = FileReader();

      reader.readAsDataUrl(file);

      reader.onLoadEnd.listen((event) {
        print("file.name : ${file.name}");
        uploadFile(file).then((value) {
          link = value;
          print("LINK 2: $link");
        });
      });
    });

    //update promise firestore
    try {
      await firestore.collection('promise').doc(promise.id).update({
        'status': 'uploaded',
        'image_scan': link,
        'diagnose.ai': stroke[Random().nextInt(3)]
      });
      print("berhasil update");
      return true;
    } catch (e) {
      print("ERROR 1: $e");
      return false;
    }
  }

  Future uploadFile(File file) async {
    //upload file ke firebase storage
    String link = "";
    try {
      final ref = await storage
          .refFromURL("gs://naraya-hack.appspot.com/")
          .child(file.name)
          .putBlob(file);
      print("berhasil upload");

      // ambil link
      link = await ref.ref.getDownloadURL();
      print("LINK 1: $link");

      return link;
    } catch (e) {
      print("ERROR 2: $e");
      return "";
    }
  }
}
