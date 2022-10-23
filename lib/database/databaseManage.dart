// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseManager {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('profileInfo');

  // ignore: non_constant_identifier_names
  Future<void> CreateUser(
      String name, String gender, int score, String uid) async {
    return await profileList
        .doc(uid)
        .set({'name': name, 'gender': gender, 'score': score});
  }

  Future getUserData() async {
    List itemList = [];
    try {
      await profileList.get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) {
          itemList.add(element.data());
        });
      });
      return itemList;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
