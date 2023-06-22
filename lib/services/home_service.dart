import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/promise_model.dart';

class HomeService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getAllPromise() async {
    try {
      var data = await firestore.collection('promise').get();

      List<Promise> promises = [];
      for (var item in data.docs) {
        promises.add(Promise.fromJson(item.data() as Map<String, dynamic>));
      }

      return promises;
    } catch (e) {
      print("ERROR: $e");
      return null;
    }
  }
}
