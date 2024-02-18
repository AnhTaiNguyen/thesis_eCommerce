import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/userModel.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUserData(UserModel userData) async {
    await _db.collection('Users').doc(userData.id).set(userData.toMap());
  }

  Future<List<UserModel>> retrieveUserData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('Users').get();
    return snapshot.docs
        .map((docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<String> retrieveUserName(UserModel user) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('Users').doc(user.id).get();
    return snapshot.data()!["displayName"];
  }
}
  // Fetch a single user by their ID
  // static Future<UserModel> getUserById(String carId) async {
  //   final document =
  //       await FirebaseFirestore.instance.collection('LAF_user').doc().get();
  //   return UserModel.fromSnapshot(document);
  // }

  // // Fetch all users
  // static Future<List<UserModel>> getAllUsers() async {
  //   final snapshot =
  //       await FirebaseFirestore.instance.collection('LAF_user').get();

  //   return snapshot.docs
  //       .map((document) => UserModel.fromSnapshot(document))
  //       .toList();
  // }