import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final int? phone;
  final String? id;
  bool? isVerified;
  final String? email;
  final String? password;
  final String? displayName;
  final int? age;
  UserModel(
      {this.id,
      this.email,
      this.password,
      this.displayName,
      this.age,
      this.isVerified,
      this.phone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'displayName': displayName,
      'age': age,
      'Verified': isVerified,
      'Phone': phone
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        email = doc.data()!["email"],
        age = doc.data()!["age"],
        displayName = doc.data()!["displayName"],
        password = doc.data()!["password"],
        isVerified = doc.data()!["Verified"],
        phone = doc.data()!["phone"];

  UserModel copyWith({
    bool? isVerified,
    String? id,
    String? email,
    String? password,
    String? displayName,
    int? age,
    int? phone,
  }) {
    return UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        displayName: displayName ?? this.displayName,
        age: age ?? this.age,
        isVerified: isVerified ?? this.isVerified,
        phone: phone ?? this.phone);
  }
}
