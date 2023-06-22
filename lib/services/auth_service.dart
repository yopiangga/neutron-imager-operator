import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      //ambil user login
      User? user = auth.currentUser;

      //ambil data user
      DocumentSnapshot snapshot =
          await firestore.collection('user').doc(user!.uid).get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      if (auth.currentUser != null) {
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("ERROR: $e");
      return null;
    }
  }

  void signOut() async {
    await auth.signOut();
  }

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

  Future getUserRole() async {
    //ambil user login
    User? user = auth.currentUser;

    //ambil data user
    DocumentSnapshot snapshot =
        await firestore.collection('user').doc(user!.uid).get();

    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return data['role'];
  }
}
