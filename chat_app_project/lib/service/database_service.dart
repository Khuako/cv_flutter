import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");
  Future saveUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "123",
      "uid": uid,
    });
  }

  Future getUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  Future getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference documentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    documentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
    });
  }
}
