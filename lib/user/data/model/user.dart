import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String name ,id; // Make id nullable

  UserModel({required this.name, required this.id}); // Make id optional

  Map<String, dynamic> toMap() => {
    'name': name,
  };

  factory UserModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel(
      name: doc.data()['name'],
      id: doc.id,
    );
  }
}
