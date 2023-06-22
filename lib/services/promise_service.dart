import '../models/promise_model.dart';
import '../models/hospital_model.dart';
import '../models/patient_model.dart';
import '../models/doctor_model.dart';
import './notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PromiseService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  NotificationService notificationService = NotificationService();

  Future getPromise() async {
    try {
      var data = await firestore.collection('promise').get();
      // query by email
      var queryByEmail = data.docs
          .where((element) =>
              element.data()['patient']['email'] == auth.currentUser!.email)
          .toList();

      //parsing data ke model promise
      List<Promise> promises = [];
      for (var item in queryByEmail) {
        promises.add(Promise.fromJson(item.data() as Map<String, dynamic>));
      }
      return promises;
    } catch (e) {
      print("ERROR: $e");
    }
  }
}
