import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseUser {
  Future<void> createUser(String userId, String firstName, String lastName);

  Future<DocumentSnapshot> getUserData(String userId);

  Future<String> getUserName(String userId);
}

class User implements BaseUser {
  final dbRef = Firestore.instance;

  Future<void> createUser(
      String userId, String firstName, String lastName) async {
    await dbRef.collection("Users").document(userId).setData({
      'name': firstName,
      'surname': lastName,
      'admin': false,
      'bookings': []
    });
  }

  Future<DocumentSnapshot> getUserData(String userId) async {
    DocumentReference userDoc = dbRef.collection("Users").document(userId);

    userDoc.get().then((data) {
      return data;
    });

    return null;
  }

  Future<String> getUserName(String userId) async {
    DocumentReference userDoc = dbRef.collection("Users").document(userId);

    var name = await userDoc.get().then((doc) async {
      return await doc.data["name"];
    }).catchError((e) {
      print(e);
    });

    return name;
  }
}
