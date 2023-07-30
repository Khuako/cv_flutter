import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService(this.uid);
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  Future saveUserData(String email) async {
    return await userCollection.doc(uid).set({
      "email" : email,
      "uid" : uid,
      "favorites":[],
    });
  }
}
